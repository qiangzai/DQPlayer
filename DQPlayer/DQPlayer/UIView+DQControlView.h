//
//  UIView+DQControlView.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQPlayerControlViewDelegate.h"
#import "DQPlayerModel.h"

@interface UIView (DQControlView)
@property (nonatomic, weak) id<DQPlayerControlViewDelegate> delegate;

//播放进度
- (void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value;

//
- (void)playerShowControlView;

- (void)playerHideControlView;

- (void)playerResetControlView;

- (void)playerItemPlaying;

- (void)playerModel:(DQPlayerModel *)playerModel;



@end
