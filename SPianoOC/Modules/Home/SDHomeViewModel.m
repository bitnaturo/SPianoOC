//
//  SDHomeViewModel.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDHomeViewModel.h"

@interface SDHomeViewModel ()

@property (nonatomic, copy, readwrite) NSString *welcomeText;
@property (nonatomic, copy, readwrite) NSString *statusText;

@end

@implementation SDHomeViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _welcomeText = @"Welcome to SPianoOC";
        _statusText = @"Ready";
    }
    return self;
}

- (void)initializeData {
    self.pageTitle = @"Home";
    self.welcomeText = @"MVVM Architecture Ready";
    self.statusText = @"Tap reload to simulate data refresh";
    [self notifyStateDidChange];
}

- (void)reloadData {
    self.loading = YES;
    self.errorMessage = nil;
    self.statusText = @"Loading...";
    [self notifyStateDidChange];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
        self.statusText = [NSString stringWithFormat:@"Last updated: %@", [NSDate date]];
        [self notifyStateDidChange];
    });
}

@end
