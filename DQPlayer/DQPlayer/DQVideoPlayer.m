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
@property (nonatomic, strong) id timeObserve;


@end

@implementation DQVideoPlayer

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.playRate = 1.0;
        
//        [self createVideoPlayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除观察者
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    
    
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player pause];
    
    [self.player removeTimeObserver:self.timeObserve];
    self.timeObserve = nil;
    
    
    
    [self.playerLayer removeFromSuperlayer];
//    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.playerItem = nil;
    self.playerLayer = nil;
}

#pragma mark - event response



#pragma mark - 对外接口
- (void)play {
    
    [self createVideoPlayer];
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

#pragma mark - private methods
- (void)createVideoPlayer {
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"QQ20170217-165908.mp4" ofType:nil];
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:self.urlPath]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive = YES;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.frame;
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    
    [self addNotification];
    
    [self createTimer];
}

- (void)addNotification {
    [self.playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
    [self.playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
    [self.playerItem addObserver:self forKeyPath:kPlayBackBufferEmpty options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
    [self.playerItem addObserver:self forKeyPath:kPlayBackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:kPlayerItemObservationContext];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    //添加视频播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

- (void)removeNotification {
    
}

- (void)removeKVO {
    //移除观察者
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
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
            NSLog(@"currentTime = %ld \n%f",(long)currentTime,totalTime);
            NSLog(@"value = %f",value);
        }
    }];
}

#pragma mark - play end
- (void)moviePlayDidEnd:(NSNotification *)notification {
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == kPlayerItemObservationContext) {
        if ([keyPath isEqualToString:kStatus]) {
            AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
            switch (status) {
                case AVPlayerStatusUnknown:
                {
                    
                }
                    break;
                case AVPlayerStatusReadyToPlay:
                {
                    NSLog(@"这里还在执行？");
                }
                    break;
                case AVPlayerStatusFailed:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        } else if ([keyPath isEqualToString:kLoadedTimeRanges]) {
            
        } else if ([keyPath isEqualToString:kPlayBackBufferEmpty]) {
            
        } else if ([keyPath isEqualToString:kPlayBackLikelyToKeepUp]) {
            
        }
    }
    
    
}


#pragma mark - setter / getter


@end
