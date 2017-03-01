//
//  DQPlayerView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

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
    
    [self removeFromSuperview];
    
    
    
}


- (void)resetToPlayNewVideo:(DQPlayerModel *)playerModel {
    [self resetPlayer];
    self.playerModel = playerModel;
    [self configPlayer];
}

- (void)play {
    
}

- (void)pause {
    
}

#pragma mark - Private Method
- (void)configPlayer {
    self.urlAsset = [AVURLAsset assetWithURL:self.videoURL];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.backgroundColor = [UIColor blackColor];
    
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self createTimer];
    
    [self play];
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
    
}

- (void)controlView:(UIView *)controlView backAction:(UIButton *)sender {
    
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
//    [self.controlView playerModel];
    [self addPlayerToFatherView:playerModel.fatherView];
    self.videoURL = playerModel.videoURL;
    
}




@end
