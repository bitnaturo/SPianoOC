//
//  UIButton+JSDButton.h
//  my job
//
//  Created by 姜守栋 on 2017/2/6.
//  Copyright © 2017年 myjob inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SDButton)

/**
 快速创建带图片的button

 @param title 文字
 @param image 图片
 @param color 文字颜色
 @return 按钮
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)color;

/**
 快速创建带背景图片的按钮

 @param title 文字
 @param backgroudImage 背景图片
 @param color 文字颜色
 @return 按钮
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title backgroudImage:(UIImage *)backgroudImage titleColor:(UIColor *)color;
/**
 创建文字在左，图片在右的按钮

 @param title 文字
 @param image 图片
 @param color 文字颜色
 @return 按钮
 */
+ (UIButton *)sd_reverseButtonWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)color;

/**
 快速创建只有文案的按钮（默认字体14）

 @param title 文字
 @param color 文字颜色
 @return 按钮
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 快速创建只有文案的按钮（可指定字体）

 @param title 文字
 @param color 文字颜色
 @param font 字体
 @return 按钮
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font;

/**
 根据文字动态调整按钮的大小

 @param title 文字内容
 @param font 字体
 @return 要调整的按钮宽度
 */
-(CGFloat)adjustWidthWithTitle:(NSString*)title font:(UIFont *)font;

@end
