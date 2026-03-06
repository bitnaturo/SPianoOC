//
//  SDBaseViewController.m
//  SPianoOC
//
//  Created by Nick on 3/4/26.
//

#import "SDBaseViewController.h"
#import "SDBaseViewModel.h"

@interface SDBaseViewController ()

@property (nonatomic, strong, readwrite) SDBaseViewModel *viewModel;

@end

@implementation SDBaseViewController

- (instancetype)initWithViewModel:(SDBaseViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithViewModel:[SDBaseViewModel new]];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _viewModel = [SDBaseViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    [self bindViewModel];
    [self setupData];
}

- (void)setupUI {
}

- (void)setupData {
    [self.viewModel initializeData];
}

- (void)bindViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.stateDidChangeBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.title = strongSelf.viewModel.pageTitle;
    };
}

@end
