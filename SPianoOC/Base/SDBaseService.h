//
//  SDBaseService.h
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SDServiceCompletionBlock)(NSDictionary * _Nullable response, NSError * _Nullable error);

@interface SDBaseService : NSObject

- (void)requestJSONWithURLString:(NSString *)URLString completion:(SDServiceCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
