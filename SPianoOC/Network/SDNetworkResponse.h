//
//  SDNetworkResponse.h
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDNetworkResponse : NSObject

@property (nonatomic, assign, readonly) BOOL success;
@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, strong, nullable, readonly) id data;
@property (nonatomic, strong, nullable, readonly) id rawObject;

+ (instancetype)responseWithSuccess:(BOOL)success
                               code:(NSInteger)code
                            message:(NSString *)message
                               data:(nullable id)data
                          rawObject:(nullable id)rawObject;

@end

NS_ASSUME_NONNULL_END
