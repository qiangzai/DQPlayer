//
//  DQVideoView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/22.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQVideoView
//  @description <#添加描述#>
//


#import "DQVideoView.h"
#import <Masonry.h>

@interface DQVideoView ()
@property (nonatomic, strong) UIView *topAlphaView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *bottomAlphaView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UISlider *progressSlider; //播放进度
@property (nonatomic, strong) UIButton *playOrPauseBtn;

@end

@implementation DQVideoView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createControlView];
        
    }
    return self;
}

#pragma mark - event response
- (void)playOrPauseBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playOrPauseButton:)]) {
        [self.delegate playOrPauseButton:sender];
    }
}

- (void)backBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}

#pragma mark - 

#pragma mark - private methods
- (void)createControlView {
    self.topAlphaView = [[UIView alloc] init];
    self.topAlphaView.backgroundColor = [UIColor blackColor];
    self.topAlphaView.alpha = 0.3;
    [self addSubview:self.topAlphaView];
    [self.topAlphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 50));
        make.left.equalTo(self.mas_left);
    }];
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topAlphaView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setBackgroundColor:[UIColor redColor]];
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.topView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
//    self.nameLabel.text = self.playName;
    [self.topView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.backBtn.mas_right).with.offset(5);
    }];
    
    
    self.bottomAlphaView = [[UIView alloc] init];
    self.bottomAlphaView.backgroundColor = [UIColor blackColor];
    self.bottomAlphaView.alpha = 0.3;
    [self addSubview:self.bottomAlphaView];
    [self.bottomAlphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topAlphaView.mas_bottom).with.offset(kDQHeight - 100);
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 50));
        make.left.equalTo(self.mas_left);
    }];
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.bottomAlphaView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playOrPauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.playOrPauseBtn addTarget:self action:@selector(playOrPauseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.playOrPauseBtn];
    [self.playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.bottomView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    
}
#pragma mark - setter / getter
- (void)setPlayName:(NSString *)playName {
    self.nameLabel.text = playName;
}
@end
