//
//  SDBaseService.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDBaseService.h"

@implementation SDBaseService

- (void)requestJSONWithURLString:(NSString *)URLString completion:(SDServiceCompletionBlock)completion {
    NSURL *URL = [NSURL URLWithString:URLString];
    if (URL == nil) {
        NSError *error = [NSError errorWithDomain:@"com.spiano.service" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Invalid URL"}];
        if (completion) {
            completion(nil, error);
        }
        return;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (data == nil) {
            NSError *emptyDataError = [NSError errorWithDomain:@"com.spiano.service" code:-2 userInfo:@{NSLocalizedDescriptionKey: @"Empty response data"}];
            if (completion) {
                completion(nil, emptyDataError);
            }
            return;
        }

        NSError *jsonError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *jsonDict = [jsonObject isKindOfClass:[NSDictionary class]] ? jsonObject : nil;

        if (completion) {
            completion(jsonDict, jsonError);
        }
    }];

    [task resume];
}

@end
