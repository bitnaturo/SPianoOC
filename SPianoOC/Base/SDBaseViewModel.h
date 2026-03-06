//
//  SDBaseViewModel.h
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SDViewModelStateDidChangeBlock)(void);

@interface SDBaseViewModel : NSObject

@property (nonatomic, copy) NSString *pageTitle;
@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, copy, nullable) NSString *errorMessage;
@property (nonatomic, copy, nullable) SDViewModelStateDidChangeBlock stateDidChangeBlock;

- (void)initializeData;
- (void)reloadData;
- (void)notifyStateDidChange;

@end

NS_ASSUME_NONNULL_END
