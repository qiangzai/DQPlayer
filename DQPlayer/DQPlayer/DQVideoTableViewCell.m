//
//  DQVideoTableViewCell.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/17.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  
//  @class DQVideoTableViewCell
//  @description video
//

#import "DQVideoTableViewCell.h"
#import <Masonry.h>

@implementation DQVideoTableViewCell

#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.fileSizeLabel];
        
        
    }
    return self;
}

#pragma mark - event response
- (void)showCellWithModel:(DQVideoModel *)model {
    
}

#pragma mark - CustomDelegate

#pragma mark -

#pragma mark - Notification

#pragma mark - private methods(可考虑提取成公用方法)

#pragma mark - setter / getter
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)fileSizeLabel {
    if (_fileSizeLabel == nil) {
        _fileSizeLabel = [[UILabel alloc] init];
    }
    return _fileSizeLabel;
}

@end
