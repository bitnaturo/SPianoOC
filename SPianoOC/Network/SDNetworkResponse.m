//
//  SDNetworkResponse.m
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import "SDNetworkResponse.h"

@interface SDNetworkResponse ()

@property (nonatomic, assign, readwrite) BOOL success;
@property (nonatomic, assign, readwrite) NSInteger code;
@property (nonatomic, copy, readwrite) NSString *message;
@property (nonatomic, strong, nullable, readwrite) id data;
@property (nonatomic, strong, nullable, readwrite) id rawObject;

@end

@implementation SDNetworkResponse

+ (instancetype)responseWithSuccess:(BOOL)success
                               code:(NSInteger)code
                            message:(NSString *)message
                               data:(id)data
                          rawObject:(id)rawObject {
    SDNetworkResponse *response = [[SDNetworkResponse alloc] init];
    response.success = success;
    response.code = code;
    response.message = message ?: @"";
    response.data = data;
    response.rawObject = rawObject;
    return response;
}

@end
