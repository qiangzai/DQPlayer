//
//  DQPlayerControlView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//  http://github.com/renzifeng

#import "DQPlayerControlView.h"
#import <Masonry.h>
#import "UIView+DQControlView.h"

@interface DQPlayerControlView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *fullBtn;
@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, strong) DQPlayerModel *playerModel;

@end

@implementation DQPlayerControlView
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomImageView];
        
        [self.topImageView addSubview:self.titleLabel];
        [self.topImageView addSubview:self.closeBtn];
        [self.topImageView addSubview:self.fullBtn];
        
        
        [self makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - Private
- (void)makeSubViewsConstraints {
    [self layoutIfNeeded];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topImageView.mas_left).with.offset(10);
        make.centerY.equalTo(self.topImageView.mas_centerY);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.centerY.equalTo(self.topImageView.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(10);
    }];
    [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.centerY.equalTo(self.topImageView.mas_centerY);
        make.left.equalTo(self.closeBtn.mas_right).with.offset(10);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)closeBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:backAction:)]) {
        [self.delegate controlView:self backAction:sender];
    }
}

- (void)fullBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:fullScreenAction:)]) {
        [self.delegate controlView:self fullScreenAction:sender];
    }
}

#pragma mark -
- (void)playerModel:(DQPlayerModel *)playerModel {
    _playerModel = playerModel;
    if (playerModel.title) {
        self.titleLabel.text = playerModel.title;
    }
}

#pragma mark -
- (void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value {
    NSLog(@"currentTime = %ld\ntotalTime = %ld\nvalue = %f",(long)currentTime,(long)totalTime,value);
}

#pragma mark - Getter
- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.image = [UIImage imageNamed:@"top_shadow"];
    }
    
    return _topImageView;
}

- (UIImageView *)bottomImageView {
    if (_bottomImageView == nil) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
        _bottomImageView.image = [UIImage imageNamed:@"bottom_shadow"];
    }
    return _bottomImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc] init];
        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)fullBtn {
    if (_fullBtn == nil) {
        _fullBtn = [[UIButton alloc] init];
        _fullBtn.backgroundColor = [UIColor redColor];
        [_fullBtn addTarget:self action:@selector(fullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullBtn;
}

@end
