//
//  DQVideoTableViewCell.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/17.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  
//  @class DQVideoTableViewCell
//  @description video
//

#import <UIKit/UIKit.h>
#import "DQVideoModel.h"

@interface DQVideoTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *fileSizeLabel;

- (void)showCellWithModel:(DQVideoModel *)model;

@end
