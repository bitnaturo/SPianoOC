//
//  SDNetworkManager.h
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import <Foundation/Foundation.h>
#import "SDNetworkConstants.h"
#import "SDNetworkResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SDNetworkCompletionBlock)(SDNetworkResponse * _Nullable response, NSError * _Nullable error);
typedef void(^SDNetworkModelCompletionBlock)(id _Nullable model, SDNetworkResponse * _Nullable response, NSError * _Nullable error);
typedef void(^SDNetworkModelArrayCompletionBlock)(NSArray * _Nullable modelArray, SDNetworkResponse * _Nullable response, NSError * _Nullable error);

@interface SDNetworkManager : NSObject

@property (nonatomic, copy, readonly) NSString *baseURLString;
@property (nonatomic, assign, readonly) NSTimeInterval timeoutInterval;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *defaultHeaders;

+ (instancetype)sharedManager;

- (void)configureWithBaseURLString:(nullable NSString *)baseURLString
                   timeoutInterval:(NSTimeInterval)timeoutInterval
                    defaultHeaders:(nullable NSDictionary<NSString *, NSString *> *)defaultHeaders;

- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;
- (void)removeValueForHTTPHeaderField:(NSString *)field;

- (nullable NSURLSessionDataTask *)requestWithMethod:(SDHTTPMethod)method
                                                path:(NSString *)path
                                          parameters:(nullable NSDictionary *)parameters
                                          completion:(SDNetworkCompletionBlock)completion;

- (nullable NSURLSessionDataTask *)requestModelWithMethod:(SDHTTPMethod)method
                                                     path:(NSString *)path
                                               parameters:(nullable NSDictionary *)parameters
                                               modelClass:(Class)modelClass
                                                  keyPath:(nullable NSString *)keyPath
                                               completion:(SDNetworkModelCompletionBlock)completion;

- (nullable NSURLSessionDataTask *)requestModelArrayWithMethod:(SDHTTPMethod)method
                                                          path:(NSString *)path
                                                    parameters:(nullable NSDictionary *)parameters
                                                    modelClass:(Class)modelClass
                                                       keyPath:(nullable NSString *)keyPath
                                                    completion:(SDNetworkModelArrayCompletionBlock)completion;

- (void)cancelTask:(NSURLSessionDataTask *)task;
- (void)cancelAllTasks;

@end

NS_ASSUME_NONNULL_END
