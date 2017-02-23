//
//  DQVideoPlayer.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/22.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQVideoPlayer
//  @description <#添加描述#>
//


#import "DQVideoPlayer.h"

static void *kPlayerItemObservationContext = &kPlayerItemObservationContext;

static NSString *kStatus = @"status";
static NSString *kLoadedTimeRanges = @"loadedTimeRanges";
static NSString *kPlayBackBufferEmpty = @"playbackBufferEmpty";
static NSString *kPlayBackLikelyToKeepUp = @"playbackLikelyToKeepUp";

@interface DQVideoPlayer ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation DQVideoPlayer

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.playRate = 1.0;
        
        [self createVideoPlayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)dealloc {
//    [super dealloc];
    self.player = nil;
    self.playerItem = nil;
    self.playerLayer = nil;
}

#pragma mark - event response



#pragma mark - 对外接口
- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

#pragma mark - private methods
- (void)createVideoPlayer {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"QQ20170217-165908.mp4" ofType:nil];
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive = YES;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.frame;
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    
    
//    [self.playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
//    [self.playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
//    [self.playerItem addObserver:self forKeyPath:kPlayBackBufferEmpty options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
//    [self.playerItem addObserver:self forKeyPath:kPlayBackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
//    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
//    //添加视频播放结束通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];

    
    
}

#pragma mark - play end
- (void)moviePlayDidEnd:(NSNotification *)notification {
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
    
    
}


#pragma mark - setter / getter


@end
