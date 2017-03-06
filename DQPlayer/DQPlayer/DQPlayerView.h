//
//  DQPlayerView.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQPlayerControlViewDelegate.h"
#import "DQPlayerControlView.h"
#import "DQPlayerModel.h"

@interface DQPlayerView : UIView <DQPlayerControlViewDelegate>

- (void)playerControlView:(UIView *)controlView playerModel:(DQPlayerModel *)playerModel;

- (void)resetPlayer;

- (void)resetToPlayNewVideo:(DQPlayerModel *)playerModel;

- (void)play;

- (void)playWithRate:(float)rate;

- (void)pause;

- (void)fullScreenAction;


@end
