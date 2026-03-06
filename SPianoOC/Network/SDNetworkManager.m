//
//  SDNetworkManager.m
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import "SDNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>

NSErrorDomain const SDNetworkErrorDomain = @"com.spiano.network";

@interface SDNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy, readwrite) NSString *baseURLString;
@property (nonatomic, assign, readwrite) NSTimeInterval timeoutInterval;
@property (nonatomic, copy, readwrite) NSDictionary<NSString *, NSString *> *defaultHeaders;

@end

@implementation SDNetworkManager

+ (instancetype)sharedManager {
    static SDNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SDNetworkManager alloc] initPrivate];
    });
    return instance;
}

- (instancetype)init {
    NSAssert(NO, @"Use +[SDNetworkManager sharedManager].");
    return [self initPrivate];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _timeoutInterval = 20.0;
        _defaultHeaders = @{};
        _baseURLString = @"http://121.37.231.197:8888";
        [self buildSessionManager];
    }
    return self;
}

- (void)configureWithBaseURLString:(NSString *)baseURLString
                   timeoutInterval:(NSTimeInterval)timeoutInterval
                    defaultHeaders:(NSDictionary<NSString *,NSString *> *)defaultHeaders {
    self.baseURLString = baseURLString ?: @"";
    self.timeoutInterval = timeoutInterval > 0.0 ? timeoutInterval : 20.0;
    self.defaultHeaders = defaultHeaders ?: @{};
    [self buildSessionManager];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    if (field.length == 0) {
        return;
    }
    if (value.length == 0) {
        [self removeValueForHTTPHeaderField:field];
        return;
    }

    NSMutableDictionary *headers = [self.defaultHeaders mutableCopy];
    headers[field] = value;
    self.defaultHeaders = headers.copy;
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)removeValueForHTTPHeaderField:(NSString *)field {
    if (field.length == 0) {
        return;
    }

    NSMutableDictionary *headers = [self.defaultHeaders mutableCopy];
    [headers removeObjectForKey:field];
    self.defaultHeaders = headers.copy;
    [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:field];
}

- (NSURLSessionDataTask *)requestWithMethod:(SDHTTPMethod)method
                                       path:(NSString *)path
                                 parameters:(NSDictionary *)parameters
                                 completion:(SDNetworkCompletionBlock)completion {
    NSString *URLString = [self absoluteURLStringWithPath:path];
    if (URLString.length == 0) {
        [self dispatchCompletion:completion response:nil error:[self errorWithCode:SDNetworkErrorCodeInvalidURL description:@"Invalid URL"]];
        return nil;
    }

    __weak typeof(self) weakSelf = self;
    void (^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        SDNetworkResponse *response = [strongSelf buildResponseWithObject:responseObject];
        NSError *businessError = nil;
        if (!response.success) {
            NSString *message = response.message.length > 0 ? response.message : @"Business error";
            businessError = [strongSelf errorWithCode:SDNetworkErrorCodeBusinessFailed description:message];
        }
        [strongSelf dispatchCompletion:completion response:response error:businessError];
    };

    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dispatchCompletion:completion response:nil error:error];
    };

    switch (method) {
        case SDHTTPMethodGET:
            return [self.sessionManager GET:URLString parameters:parameters headers:nil progress:nil success:successBlock failure:failureBlock];
        case SDHTTPMethodPOST:
            return [self.sessionManager POST:URLString parameters:parameters headers:nil progress:nil success:successBlock failure:failureBlock];
        case SDHTTPMethodPUT:
            return [self.sessionManager PUT:URLString parameters:parameters headers:nil success:successBlock failure:failureBlock];
        case SDHTTPMethodDELETE:
            return [self.sessionManager DELETE:URLString parameters:parameters headers:nil success:successBlock failure:failureBlock];
    }
}

- (NSURLSessionDataTask *)requestModelWithMethod:(SDHTTPMethod)method
                                            path:(NSString *)path
                                      parameters:(NSDictionary *)parameters
                                      modelClass:(Class)modelClass
                                         keyPath:(NSString *)keyPath
                                      completion:(SDNetworkModelCompletionBlock)completion {
    __weak typeof(self) weakSelf = self;
    return [self requestWithMethod:method path:path parameters:parameters completion:^(SDNetworkResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error != nil || response == nil) {
            [strongSelf dispatchModelCompletion:completion model:nil response:response error:error];
            return;
        }

        id payload = [strongSelf payloadFromResponse:response keyPath:keyPath];
        id model = nil;
        NSError *mappingError = nil;
        if (payload != nil && modelClass != Nil) {
            model = [modelClass yy_modelWithJSON:payload];
            if (model == nil) {
                mappingError = [strongSelf errorWithCode:SDNetworkErrorCodeModelMappingFailed description:@"YYModel mapping failed"];
            }
        }

        [strongSelf dispatchModelCompletion:completion model:model response:response error:mappingError];
    }];
}

- (NSURLSessionDataTask *)requestModelArrayWithMethod:(SDHTTPMethod)method
                                                 path:(NSString *)path
                                           parameters:(NSDictionary *)parameters
                                           modelClass:(Class)modelClass
                                              keyPath:(NSString *)keyPath
                                           completion:(SDNetworkModelArrayCompletionBlock)completion {
    __weak typeof(self) weakSelf = self;
    return [self requestWithMethod:method path:path parameters:parameters completion:^(SDNetworkResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error != nil || response == nil) {
            [strongSelf dispatchModelArrayCompletion:completion modelArray:nil response:response error:error];
            return;
        }

        id payload = [strongSelf payloadFromResponse:response keyPath:keyPath];
        if (payload == nil) {
            [strongSelf dispatchModelArrayCompletion:completion modelArray:@[] response:response error:nil];
            return;
        }

        if (![payload isKindOfClass:[NSArray class]]) {
            NSError *mappingError = [strongSelf errorWithCode:SDNetworkErrorCodeModelMappingFailed description:@"Expected an array payload for model array mapping"];
            [strongSelf dispatchModelArrayCompletion:completion modelArray:nil response:response error:mappingError];
            return;
        }

        NSArray *modelArray = [NSArray yy_modelArrayWithClass:modelClass json:payload];
        NSError *mappingError = nil;
        if (modelArray == nil) {
            mappingError = [strongSelf errorWithCode:SDNetworkErrorCodeModelMappingFailed description:@"YYModel array mapping failed"];
        }

        [strongSelf dispatchModelArrayCompletion:completion modelArray:modelArray response:response error:mappingError];
    }];
}

- (void)cancelTask:(NSURLSessionDataTask *)task {
    [task cancel];
}

- (void)cancelAllTasks {
    NSArray<NSURLSessionDataTask *> *tasks = self.sessionManager.tasks;
    for (NSURLSessionDataTask *task in tasks) {
        [task cancel];
    }
}

#pragma mark - Private

- (void)buildSessionManager {
    NSURL *baseURL = self.baseURLString.length > 0 ? [NSURL URLWithString:self.baseURLString] : nil;
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
        @"application/json",
        @"text/json",
        @"text/javascript",
        @"text/plain",
        @"text/html"
    ]];

    [self.defaultHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

- (NSString *)absoluteURLStringWithPath:(NSString *)path {
    if (path.length == 0) {
        return @"";
    }
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        return path;
    }
    if (self.baseURLString.length == 0) {
        return path;
    }

    NSString *trimmedBase = [self.baseURLString hasSuffix:@"/"] ? [self.baseURLString substringToIndex:self.baseURLString.length - 1] : self.baseURLString;
    NSString *trimmedPath = [path hasPrefix:@"/"] ? [path substringFromIndex:1] : path;
    return [NSString stringWithFormat:@"%@/%@", trimmedBase, trimmedPath];
}

- (SDNetworkResponse *)buildResponseWithObject:(id)responseObject {
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        return [SDNetworkResponse responseWithSuccess:YES code:0 message:@"" data:responseObject rawObject:responseObject];
    }

    NSDictionary *dict = (NSDictionary *)responseObject;
    NSNumber *codeNumber = [dict[@"code"] isKindOfClass:[NSNumber class]] ? dict[@"code"] : @0;
    NSInteger code = codeNumber.integerValue;
    NSString *message = @"";
    if ([dict[@"message"] isKindOfClass:[NSString class]]) {
        message = dict[@"message"];
    } else if ([dict[@"msg"] isKindOfClass:[NSString class]]) {
        message = dict[@"msg"];
    }

    BOOL success = YES;
    if ([dict[@"success"] respondsToSelector:@selector(boolValue)]) {
        success = [dict[@"success"] boolValue];
    } else if (dict[@"code"] != nil) {
        success = (code == 0);
    }

    id data = dict[@"data"] ?: responseObject;
    return [SDNetworkResponse responseWithSuccess:success code:code message:message data:data rawObject:responseObject];
}

- (id)payloadFromResponse:(SDNetworkResponse *)response keyPath:(NSString *)keyPath {
    if (keyPath.length == 0) {
        return response.data;
    }

    id source = response.rawObject ?: response.data;
    if (source == nil) {
        return nil;
    }

    @try {
        return [source valueForKeyPath:keyPath];
    } @catch (NSException *exception) {
        return nil;
    }
}

- (NSError *)errorWithCode:(SDNetworkErrorCode)code description:(NSString *)description {
    return [NSError errorWithDomain:SDNetworkErrorDomain
                               code:code
                           userInfo:@{NSLocalizedDescriptionKey: description ?: @"Network error"}];
}

- (void)dispatchCompletion:(SDNetworkCompletionBlock)completion
                  response:(SDNetworkResponse *)response
                     error:(NSError *)error {
    if (!completion) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(response, error);
    });
}

- (void)dispatchModelCompletion:(SDNetworkModelCompletionBlock)completion
                          model:(id)model
                       response:(SDNetworkResponse *)response
                          error:(NSError *)error {
    if (!completion) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(model, response, error);
    });
}

- (void)dispatchModelArrayCompletion:(SDNetworkModelArrayCompletionBlock)completion
                           modelArray:(NSArray *)modelArray
                             response:(SDNetworkResponse *)response
                                error:(NSError *)error {
    if (!completion) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(modelArray, response, error);
    });
}

@end
