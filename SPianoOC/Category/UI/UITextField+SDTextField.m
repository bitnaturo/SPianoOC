//
//  UITextField+JSDTextField.m
//  my job
//
//  Created by 姜守栋 on 2017/8/8.
//  Copyright © 2017年 myjob inc. All rights reserved.
//

#import "UITextField+SDTextField.h"

@implementation UITextField (SDTextField)

+ (instancetype)sd_makeTextFieldWithPlaceholder:(NSString *)placeholder{
    UITextField *textFld = [UITextField new];
    textFld.placeholder = placeholder;
    
    return textFld;
}
@end
