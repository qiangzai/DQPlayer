//
//  DQPlayerView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//  有播放能力的view层


#import "DQPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+DQControlView.h"
#import <Masonry.h>

@interface DQPlayerView ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) id timeObserve;

@property (nonatomic, strong) UIView *controlView;
@property (nonatomic, strong) DQPlayerModel *playerModel;
@property (nonatomic, assign) NSInteger seekTime;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSDictionary *resolutionDic;
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation DQPlayerView

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    self.playerItem = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.timeObserve) {
        [self.player removeTimeObserver:self];
        self.timeObserve = nil;
    }
}

- (void)resetToPlayNewURL {
    
}

#pragma mark - 观察者、通知
- (void)addNotifications {
    
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.playerLayer.frame = self.bounds;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

#pragma mark - Public Method
- (void)playerControlView:(UIView *)controlView playerModel:(DQPlayerModel *)playerModel {
    if (!controlView) {
        DQPlayerControlView *defaultControlView = [[DQPlayerControlView alloc] init];
        self.controlView = defaultControlView;
    } else {
        self.controlView = controlView;
    }
    self.playerModel = playerModel;
}

- (void)addPlayerToFatherView:(UIView *)view {
    [self removeFromSuperview];
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
}

- (void)resetPlayer {
    self.playerItem = nil;
    self.seekTime = 0;
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self pause];
    
    [self.playerLayer removeFromSuperlayer];
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    self.player = nil;
    
    [self.controlView playerResetControlView];
    
    self.controlView = nil;
    
//    [self removeFromSuperview];
    
    
    
}


- (void)resetToPlayNewVideo:(DQPlayerModel *)playerModel {
    [self resetPlayer];
    self.playerModel = playerModel;
    [self configPlayer];
}

- (void)play {
//    [self configPlayer];
    [_player play];
//    [_player playImmediatelyAtRate:2.0];
}

- (void)playWithRate:(float)rate {
    [_player playImmediatelyAtRate:rate];
}

- (void)pause {
    [_player pause];
}

#pragma mark - Private Method
- (void)configPlayer {
//    self.urlAsset = [AVURLAsset assetWithURL:self.videoURL];
//    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.playerItem = [AVPlayerItem playerItemWithURL:self.videoURL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self createTimer];
    
//    [self play];
}

- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time) {
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            [weakSelf.controlView playerCurrentTime:currentTime totalTime:totalTime sliderValue:value];
            
        }
    }];
}

- (void)fullScreenAction {
    //先从小屏到大屏
    if (self.isFullScreen) {
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
        self.isFullScreen = NO;
        return;
    } else {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeRight) {
            [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
        } else {
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
        self.isFullScreen = YES;
    }
    
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
        // 设置横屏
        [self setOrientationLandscapeConstraint:orientation];
    } else if (orientation == UIInterfaceOrientationPortrait) {
        // 设置竖屏
        [self setOrientationPortraitConstraint];
    }
}

- (void)setOrientationPortraitConstraint {
//    [self addPlayerToFatherView:self.playerModel.fatherView];
    [self toOrientation:UIInterfaceOrientationPortrait];
    self.isFullScreen = NO;
}

- (void)setOrientationLandscapeConstraint:(UIInterfaceOrientation)orientation {
    [self toOrientation:orientation];
    self.isFullScreen = YES;
}

- (void)toOrientation:(UIInterfaceOrientation)orientation {
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) { return; }
    
    // 根据要旋转的方向,使用Masonry重新修改限制
    if (orientation != UIInterfaceOrientationPortrait) {//
        // 这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
        if (currentOrientation == UIInterfaceOrientationPortrait) {
            [self removeFromSuperview];
//            ZFBrightnessView *brightnessView = [ZFBrightnessView sharedBrightnessView];
            
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(kDQHeight));
                make.height.equalTo(@(kDQWidth));
                make.center.equalTo([UIApplication sharedApplication].keyWindow);
            }];
            
        }
    }
    // iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    // 也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    self.transform = CGAffineTransformIdentity;
    self.transform = [self getTransformRotationAngle];
    // 开始旋转
    [UIView commitAnimations];
    [self.controlView layoutIfNeeded];
    [self.controlView setNeedsLayout];
}

- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) {
            
            if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                [self setNeedsLayout];
                [self layoutIfNeeded];
                
                [self.layer insertSublayer:self.playerLayer atIndex:0];
                
                if (self.seekTime) {
//                    [self seekToTime:self.seekTime completionHandler:nil];
                }
            } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
                
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            //缓冲
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            
        }
    }
}

#pragma mark - DQPlayerControlViewDelegate
- (void)controlView:(UIView *)controlView playAction:(UIButton *)sender {
    
    if (sender.selected) {
        [self play];
    } else {
        [self pause];
    }
    sender.selected = !sender.selected;
    
}

- (void)controlView:(UIView *)controlView backAction:(UIButton *)sender {
    [self fullScreenAction];
    [self resetPlayer];
    [self removeFromSuperview];
    
    
    
//    [UIView animateWithDuration:2 animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
}

- (void)controlView:(UIView *)controlView fullScreenAction:(UIButton *)sender {
    [self fullScreenAction];
}

- (void)controlView:(UIView *)controlView rateAction:(UIButton *)sender {
    NSLog(@"text = %@",sender.titleLabel.text);
    [self playWithRate:1.0];
    
}


#pragma mark - Setter
- (void)setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    if (_playerItem == playerItem) {
        return;
    }
    
    if (_playerItem) {
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setControlView:(UIView *)controlView {
    if (_controlView) {
        return;
    }
    
    _controlView = controlView;
    controlView.delegate = self;
    [self layoutIfNeeded];
    [self addSubview:controlView];
    [controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setPlayerModel:(DQPlayerModel *)playerModel {
    _playerModel = playerModel;
    if (playerModel.seekTime) {
        self.seekTime = playerModel.seekTime;
    }
    [self.controlView playerModel:playerModel];
    [self addPlayerToFatherView:playerModel.fatherView];
    self.videoURL = playerModel.videoURL;
    
}




@end
