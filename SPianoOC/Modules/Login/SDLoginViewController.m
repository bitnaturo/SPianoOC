//
//  SDLoginViewController.m
//  SPianoOC
//
//  Created by Nick on 3/6/26.
//

#import "SDLoginViewController.h"
#import "SDUserModel.h"
#import <YYModel/YYModel.h>
#import "SDHomeViewController.h"
@interface SDLoginViewController ()

@property(nonatomic, strong) UITextField *phoneNumTextField;
@property(nonatomic, strong) UITextField *codeTextField;
@property(nonatomic, strong) UIButton *loginBtn;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)login {
    NSDictionary *params = @{
        @"mobile": @"18366289056",
        @"type": @(1),
        @"smsCode": @"1",
        @"hasAgreeProtocol": @(NO)
    };
    
    [[SDNetworkManager sharedManager] requestModelWithMethod:SDHTTPMethodPOST
                                                        path:@"/auth/login-sms"
                                                  parameters:params
                                                  modelClass:[SDUserModel class]
                                                     keyPath:@""
                                                  completion:
     ^(SDUserModel *user, SDNetworkResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"响应 %@", user.token);
//        [[NSUserDefaults standardUserDefaults] setValue:user.token forKey:@"token"];
            SDHomeViewController *homeViewController = [[SDHomeViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = homeViewController;
    }];
}

- (void)setupUI {
    self.phoneNumTextField = [UITextField sd_makeTextFieldWithPlaceholder:@"请输入手机号"];
    [self.phoneNumTextField border:1 color:UIColor.redColor];
    self.codeTextField = [UITextField sd_makeTextFieldWithPlaceholder:@"请输入验证码"];
    [self.codeTextField border:1 color:UIColor.redColor];
    self.loginBtn = [UIButton sd_buttonWithTitle:@"登陆" titleColor:[UIColor systemPinkColor]];
    [self.loginBtn setSize:CGSizeMake(300, 50)];
    [self.loginBtn border:1 color:UIColor.greenColor];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.loginBtn];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(200);
        make.width.equalTo(@(300));
        make.height.equalTo(@(50));
    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.phoneNumTextField.mas_bottom).offset(50);
        make.width.equalTo(@(300));
        make.height.equalTo(@(50));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(50);
        make.width.equalTo(@(300));
        make.height.equalTo(@(50));
    }];
    
}

@end
