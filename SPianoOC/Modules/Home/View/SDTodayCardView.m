//
//  SDTodayCardView.m
//  SPianoOC
//
//  Created by Nick on 3/5/26.
//

#import "SDTodayCardView.h"

@interface SDTodayCardView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) UILabel *musicName;
@property(nonatomic, strong) UILabel *musicCover;
@property(nonatomic, strong) UIButton *playButton;


@end

@implementation SDTodayCardView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self rounded:16 width:1 color:[UIColor sd_colorWithHex:0xB4CBE5]];
    
    self.titleLabel = [UILabel sd_labelWithText:@"今天适合听"
                                       fontName:@"PingFang SC"
                                       fontSize:12
                                     fontWeight:500
                                          color:
                       [UIColor sd_colorWithHex:0x262626]];
    
    self.musicName = [UILabel sd_labelWithText:@"天空之城"
                                      fontName:@"PingFang SC"
                                      fontSize:14
                                    fontWeight:400
                                         color:
                      [UIColor sd_colorWithHex:0x262626]];
    
    self.iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"todayCover"]];
    
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(19);
    }];
    
    [self addSubview:self.musicName];
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.musicName.mas_bottom).offset(8);
    }];
    
    
    
}

@end
