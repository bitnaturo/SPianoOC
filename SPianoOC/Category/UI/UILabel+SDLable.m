//
//  UILabel+JSDLable.m
//  my job
//
//  Created by 姜守栋 on 2017/2/4.
//  Copyright © 2017年 myjob inc. All rights reserved.
//

#import "UILabel+SDLable.h"

@implementation UILabel (SDLable)

+ (instancetype)sd_labelWithText:(NSString *)text {
    return [self sd_labelWithText:text fontName:nil fontSize:14.0 fontWeight:UIFontWeightRegular color:nil];
}

+ (instancetype)sd_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self sd_labelWithText:text fontName:nil fontSize:fontSize fontWeight:UIFontWeightRegular color:nil];
}

+ (instancetype)sd_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    return [self sd_labelWithText:text fontName:nil fontSize:fontSize fontWeight:UIFontWeightRegular color:color];
}

+ (instancetype)sd_labelWithText:(NSString *)text
                        fontName:(NSString *)fontName
                        fontSize:(CGFloat)fontSize
                      fontWeight:(CGFloat)fontWeight
                           color:(UIColor *)color {
    UILabel *label = [[self alloc] init];

    label.text = text ?: @"";

    CGFloat finalFontSize = fontSize > 0.0 ? fontSize : 14.0;
    if (fontName.length > 0) {
        UIFont *customFont = [UIFont fontWithName:fontName size:finalFontSize];
        label.font = customFont ?: [UIFont systemFontOfSize:finalFontSize weight:fontWeight];
    } else {
        label.font = [UIFont systemFontOfSize:finalFontSize weight:fontWeight];
    }

    label.textColor = color ?: [UIColor labelColor];
    label.numberOfLines = 0;

    return label;
}

@end
