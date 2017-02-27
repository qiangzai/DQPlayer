//
//  DQVideoPlayer.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/22.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQVideoPlayer
//  @description 播放层
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol DQVideoPlayerDelegate <NSObject>



@end



@interface DQVideoPlayer : UIView
@property (nonatomic, assign) float playRate;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, copy) NSString *urlPath;

/**
 播放
 */
- (void)play;


/**
 暂停
 */
- (void)pause;

@end
