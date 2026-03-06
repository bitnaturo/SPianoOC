//
//  SDHomeViewModel.h
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDHomeViewModel : SDBaseViewModel

@property (nonatomic, copy, readonly) NSString *welcomeText;
@property (nonatomic, copy, readonly) NSString *statusText;

@end

NS_ASSUME_NONNULL_END
