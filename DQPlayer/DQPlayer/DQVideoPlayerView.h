//
//  DQVideoPlayerView.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/16.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  
//  @class DQVideoPlayerView
//  @description 视频封装层
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DQVideoPlayerView;
@protocol DQVideoPlayerViewDelegate <NSObject>
@optional
//全屏/非全屏切换
- (void)videoPlayer:(DQVideoPlayerView *)videoPlayer clickFullButton:(UIButton *)fullButton;

@end
@interface DQVideoPlayerView : UIView
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) NSString *playUrl;                //视频播放路径（本地or网络）
@property (nonatomic, weak) id<DQVideoPlayerViewDelegate> delegate;
@property (nonatomic, assign) BOOL netResource;             //是否是网络视频

//关于View层  是否可封装到另一类中
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *pauseAndPlayBtn;
@property (nonatomic, strong) UIButton *fullBtn;



- (void)play;



@end
