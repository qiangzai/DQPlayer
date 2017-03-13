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
#import <AVFoundation/AVFoundation.h>

@implementation DQVideoTableViewCell

#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //one bug about github desktop
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.fileSizeLabel];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100, 70));
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).with.offset(5);
            make.top.equalTo(self.imgView.mas_top);
        }];
        [self.fileSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).with.offset(5);
            make.bottom.equalTo(self.imgView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)showCellWithModel:(DQVideoModel *)model {
//    self.nameLabel.text = model.name;
//    self.fileSizeLabel.text = model.size;
//    self.imgView.image = [self videoPreViewImageWithUrl:model.path];
    
    self.nameLabel.text = @"标题名字";
    self.fileSizeLabel.text = @"1.5M";
//    self.imgView.image = [self videoPreViewImageWithUrl:model.path];
    
}

#pragma mark - CustomDelegate

#pragma mark -

#pragma mark - Notification

#pragma mark - private methods(可考虑提取成公用方法)
- (UIImage *)videoPreViewImageWithUrl:(NSString *)url {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:url] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
    
}

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
