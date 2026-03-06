//
//  SDNetworkConstants.h
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSErrorDomain const SDNetworkErrorDomain;

typedef NS_ENUM(NSInteger, SDNetworkErrorCode) {
    SDNetworkErrorCodeInvalidURL = 10001,
    SDNetworkErrorCodeInvalidResponse = 10002,
    SDNetworkErrorCodeBusinessFailed = 10003,
    SDNetworkErrorCodeModelMappingFailed = 10004
};

typedef NS_ENUM(NSUInteger, SDHTTPMethod) {
    SDHTTPMethodGET,
    SDHTTPMethodPOST,
    SDHTTPMethodPUT,
    SDHTTPMethodDELETE
};

NS_ASSUME_NONNULL_END
