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

- (void)controlView:(UIView *)controlView backAction:(UIButton *)sender;

- (void)controlView:(UIView *)controlView playAction:(UIButton *)sender;

- (void)controlView:(UIView *)controlView fullScreenAction:(UIButton *)sender;



@end



























