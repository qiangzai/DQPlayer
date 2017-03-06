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
@property (nonatomic, strong) UIButton *backBtn;
//@property (nonatomic, strong) UIButton *fullBtn;

@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *timeLabel;
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
        [self.topImageView addSubview:self.backBtn];
//        [self.topImageView addSubview:self.fullBtn];
        
        [self.bottomImageView addSubview:self.playBtn];
        [self.bottomImageView addSubview:self.timeLabel];
        
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
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self.topImageView.mas_centerY);
        make.left.equalTo(self.topImageView.mas_left).with.offset(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.mas_right).with.offset(10);
        make.centerY.equalTo(self.topImageView.mas_centerY);
    }];
    
//    [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(80, 40));
//        make.centerY.equalTo(self.topImageView.mas_centerY);
//        make.left.equalTo(self.closeBtn.mas_right).with.offset(10);
//    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.left.equalTo(self.bottomImageView.mas_left).with.offset(5);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn.mas_right).with.offset(5);
        make.bottom.equalTo(self.bottomImageView.mas_bottom).with.offset(-5);
    }];
}

#pragma mark - event
- (void)backBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:backAction:)]) {
        [self.delegate controlView:self backAction:sender];
    }
}

//- (void)fullBtnClick:(UIButton *)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:fullScreenAction:)]) {
//        [self.delegate controlView:self fullScreenAction:sender];
//    }
//}

- (void)playBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:playAction:)]) {
        [self.delegate controlView:self playAction:sender];
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
    self.timeLabel.text = [NSString stringWithFormat:@"%ld / %ld",currentTime,totalTime];
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

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        
//        [_backBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

//- (UIButton *)fullBtn {
//    if (_fullBtn == nil) {
//        _fullBtn = [[UIButton alloc] init];
//        _fullBtn.backgroundColor = [UIColor redColor];
//        [_fullBtn setTitle:@"全屏" forState:UIControlStateNormal];
//        [_fullBtn addTarget:self action:@selector(fullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _fullBtn;
//}

- (UIButton *)playBtn {
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}

@end
