//
//  SDHomeViewController.m
//  SPianoOC
//
//  Created by Nick on 3/5/26.
//

#import "SDHomeViewController.h"
#import "SDTodayCardView.h"

@interface SDHomeViewController ()

@end

@implementation SDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    SDTodayCardView *todayCard = [[SDTodayCardView alloc] initWithFrame: CGRectZero];
    
    [self.view addSubview: todayCard];
    
    [todayCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(200);
        make.width.equalTo(@(252));
        make.height.equalTo(@(317));
    }];
}
@end
