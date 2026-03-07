//
//  UIButton+JSDButton.m
//  my job
//
//  Created by 姜守栋 on 2017/2/6.
//  Copyright © 2017年 myjob inc. All rights reserved.
//

#import "UIButton+SDButton.h"

@implementation UIButton (SDButton)

+ (CGFloat)sd_activeScreenWidth {
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (![scene isKindOfClass:[UIWindowScene class]]) {
                continue;
            }
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            if (windowScene.activationState == UISceneActivationStateForegroundActive ||
                windowScene.activationState == UISceneActivationStateForegroundInactive) {
                return windowScene.screen.bounds.size.width;
            }
        }
    }
    return 375.0;
}

+ (UIButton *)sd_buttonWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)color{
    CGFloat padding = ([self sd_activeScreenWidth] == 320.0) ? 3.0 : 5.0;
    UIButton *btn = [self new];
    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
        configuration.title = title;
        configuration.image = image;
        configuration.baseForegroundColor = color;
        configuration.imagePadding = padding;
        configuration.contentInsets = NSDirectionalEdgeInsetsZero;
        configuration.titleTextAttributesTransformer = ^NSDictionary<NSAttributedStringKey, id> * _Nonnull(NSDictionary<NSAttributedStringKey,id> * _Nonnull incoming) {
            NSMutableDictionary<NSAttributedStringKey, id> *attributes = [incoming mutableCopy] ?: [NSMutableDictionary dictionary];
            attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
            return attributes;
        };
        btn.configuration = configuration;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, padding, 0, -padding)];
#pragma clang diagnostic pop
    }
    [btn sizeToFit];
    return btn;
}
+ (UIButton *)sd_buttonWithTitle:(NSString *)title backgroudImage:(UIImage *)backgroudImage titleColor:(UIColor *)color{
    UIButton *btn = [self new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:backgroudImage forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn sizeToFit];
    return btn;
}
+ (UIButton *)sd_reverseButtonWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)color{
    UIButton *btn = [self new];
    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
        configuration.title = title;
        configuration.image = image;
        configuration.baseForegroundColor = color;
        configuration.imagePlacement = NSDirectionalRectEdgeTrailing;
        configuration.contentInsets = NSDirectionalEdgeInsetsZero;
        btn.configuration = configuration;
    } else {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
    [btn sizeToFit];
    
    return btn;
}
+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color{
    return [self sd_buttonWithTitle:title titleColor:color font:[UIFont systemFontOfSize:14.0]];
}

+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font{
    UIButton *btn = [self new];
    UIFont *buttonFont = font ?: [UIFont systemFontOfSize:14.0];
    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
        configuration.title = title;
        configuration.baseForegroundColor = color;
        configuration.contentInsets = NSDirectionalEdgeInsetsZero;
        configuration.titleTextAttributesTransformer = ^NSDictionary<NSAttributedStringKey, id> * _Nonnull(NSDictionary<NSAttributedStringKey,id> * _Nonnull incoming) {
            NSMutableDictionary<NSAttributedStringKey, id> *attributes = [incoming mutableCopy] ?: [NSMutableDictionary dictionary];
            attributes[NSFontAttributeName] = buttonFont;
            return attributes;
        };
        btn.configuration = configuration;
    } else {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.titleLabel.font = buttonFont;
    }
    [btn sizeToFit];
    return btn;
}

- (CGFloat)adjustWidthWithTitle:(NSString*)title font:(UIFont *)font{
    NSString *content = title;
    CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    return buttonSize.width + 4;

}
@end
