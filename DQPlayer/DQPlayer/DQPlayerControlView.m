//
//  DQPlayerControlView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//  http://github.com/renzifeng
//  播放器的控制层

#import "DQPlayerControlView.h"
#import <Masonry.h>
#import "UIView+DQControlView.h"

@interface DQPlayerControlView ()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *rateBtn;
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

- (void)rateBtnClick:(UIButton *)sender {
    //1.0 1.5 2.0
    
    
    
    
    
    
}

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
    self.timeLabel.text = [NSString stringWithFormat:@"%@ / %@",[self durationStringWithTime:currentTime],[self durationStringWithTime:totalTime]];
}

- (NSString *)durationStringWithTime:(int)time {
    NSString *min = [NSString stringWithFormat:@"%02d",time / 60];
    NSString *sec = [NSString stringWithFormat:@"%02d",time % 60];
    return [NSString stringWithFormat:@"%@:%@",min,sec];
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
        [_backBtn setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

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

- (UIButton *)rateBtn {
    if (_rateBtn == nil) {
        _rateBtn = [[UIButton alloc] init];
        [_rateBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_rateBtn setTitle:@"X 1.0" forState:UIControlStateNormal];
        [_rateBtn setTintColor:[UIColor whiteColor]];
        [_rateBtn addTarget:self action:@selector(rateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rateBtn;
}

@end
