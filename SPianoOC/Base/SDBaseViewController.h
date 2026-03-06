//
//  SDBaseViewController.h
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import <UIKit/UIKit.h>

@class SDBaseViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface SDBaseViewController : UIViewController

@property (nonatomic, strong, readonly) SDBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(SDBaseViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

- (void)setupUI;
- (void)setupData;
- (void)bindViewModel;

@end

NS_ASSUME_NONNULL_END
