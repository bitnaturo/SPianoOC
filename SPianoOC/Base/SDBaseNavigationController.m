//
//  SDBaseNavigationController.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDBaseNavigationController.h"

@interface SDBaseNavigationController ()

@end

@implementation SDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.prefersLargeTitles = NO;
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
