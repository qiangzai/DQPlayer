//
//  UIView+DQControlView.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import "UIView+DQControlView.h"
#import <objc/runtime.h>

@implementation UIView (DQControlView)

- (void)setDelegate:(id<DQPlayerControlViewDelegate>)delegate {
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<DQPlayerControlViewDelegate>)delegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value {}

- (void)playerShowControlView {}

- (void)playerHideControlView {}

- (void)playerResetControlView {}

- (void)playerItemPlaying {}

- (void)playerModel:(DQPlayerModel *)playerModel {}


@end
