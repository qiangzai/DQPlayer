//
//  DQPlayerControlViewDelegate.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#ifndef DQPlayerControlViewDelegate_h
#define DQPlayerControlViewDelegate_h


#endif /* DQPlayerControlViewDelegate_h */


@protocol DQPlayerControlViewDelegate <NSObject>

@optional
//返回
- (void)controlView:(UIView *)controlView backAction:(UIButton *)sender;
//播放 暂停
- (void)controlView:(UIView *)controlView playAction:(UIButton *)sender;
//全屏
- (void)controlView:(UIView *)controlView fullScreenAction:(UIButton *)sender;
//关闭
- (void)controlView:(UIView *)controlView closeScreenAction:(UIButton *)sender;


@end



























