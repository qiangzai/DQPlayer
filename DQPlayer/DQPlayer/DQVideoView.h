//
//  DQVideoView.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/22.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQVideoView
//  @description 控制视频层
//

#import <UIKit/UIKit.h>


@protocol DQVideoViewDelegate <NSObject>

- (void)playOrPauseButton:(UIButton *)button;

@end

@interface DQVideoView : UIView

@property (nonatomic, weak) id <DQVideoViewDelegate> delegate;
//top

//bottom

//center 手势控制



@property (nonatomic, assign) NSString *playName;


@end
