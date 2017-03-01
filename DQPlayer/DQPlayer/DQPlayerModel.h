//
//  DQPlayerModel.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/3/1.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DQPlayerModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, assign) NSInteger seekTime;
@property (nonatomic, weak) UIView *fatherView;
@end
