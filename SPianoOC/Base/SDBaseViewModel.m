//
//  SDBaseViewModel.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDBaseViewModel.h"

@implementation SDBaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageTitle = @"";
        _loading = NO;
        _errorMessage = nil;
    }
    return self;
}

- (void)initializeData {
    // Subclasses override to prepare first screen state.
}

- (void)reloadData {
    // Subclasses override for actual loading behavior.
    [self notifyStateDidChange];
}

- (void)notifyStateDidChange {
    if (self.stateDidChangeBlock == nil) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.stateDidChangeBlock();
    });
}

@end
