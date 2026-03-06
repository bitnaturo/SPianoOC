//
//  UILabel+JSDLable.h
//  my job
//
//  Created by 姜守栋 on 2017/2/4.
//  Copyright © 2017年 myjob inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SDLable)

+ (instancetype)sd_labelWithText:(nullable NSString *)text;

+ (instancetype)sd_labelWithText:(nullable NSString *)text
                        fontSize:(CGFloat)fontSize;

+ (instancetype)sd_labelWithText:(nullable NSString *)text
                        fontSize:(CGFloat)fontSize
                           color:(nullable UIColor *)color;

+ (instancetype)sd_labelWithText:(nullable NSString *)text
                        fontName:(nullable NSString *)fontName
                        fontSize:(CGFloat)fontSize
                      fontWeight:(CGFloat)fontWeight
                           color:(nullable UIColor *)color;

@end
NS_ASSUME_NONNULL_END

