//
//  SceneDelegate.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SceneDelegate.h"
#import "SDHomeViewController.h"
#import "SDBaseNavigationController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if (![scene isKindOfClass:[UIWindowScene class]]) {
        return;
    }

    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    SDHomeViewController *homeViewController = [[SDHomeViewController alloc] init];
    SDBaseNavigationController *navigationController = [[SDBaseNavigationController alloc] initWithRootViewController:homeViewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
}

- (void)sceneWillResignActive:(UIScene *)scene {
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
}

@end
