//
//  ViewController.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/16.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "DQVideoPlayerView.h"

#define kDQWidth       ([[UIScreen mainScreen] bounds].size.width)
#define kDQHeight      ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<DQVideoPlayerViewDelegate>
@property (nonatomic, strong) DQVideoPlayerView *video;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.video = [[DQVideoPlayerView alloc] init];
    self.video.delegate = self;
    
    self.video.frame = CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, 200);//必须指定frame AVPlayerLayer是layer 不可使用autolayout
    [self.view addSubview:self.video];
    
}

- (IBAction)test:(UIButton *)sender {
    //可以播放视频了，虽然控制视频播放的功能好多没搞，但是最让我纠结的屏幕旋转搞定了，顺便，你可以告诉我这电影名字吗？
    NSString *url = @"http://flv2.bn.netease.com/videolib3/1612/01/dcXyV2964/SD/dcXyV2964-mobile.mp4";
    if (url.length <= 0) {
        //提示框
        return;
    }
    
    if (![self isTrueUrl:url]) {
        //如何判断是资源文件
        return;
    }
    
    self.video.playUrl = url;
    [self.video play];
}

- (BOOL)isTrueUrl:(NSString *)url {
    NSString *regex = @"^((https|http|ftp|rtsp|mms)?://)?(([0-9a-zA-Z_!~*'().&=+$%-]+: )?[0-9a-zA-Z_!~*'().&=+$%-]+@)?(([0-9]{1,3}\\.){3}[0-9]{1,3}|(\\[([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[[0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){1,7}:\\](:[1-9]([0-9]){0,4})?)|([0-9a-zA-Z_!~*'()-]+\\.)*([0-9a-zA-Z][0-9a-zA-Z-]{0,61})?[0-9a-zA-Z]\\.[a-zA-Z]{2,6})(:[0-9]{1,4})?((/?)|(/[0-9a-zA-Z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:url];
}

- (void)videoPlayer:(DQVideoPlayerView *)videoPlayer clickFullButton:(UIButton *)fullButton {
    if (fullButton.isSelected) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
        
        [self.video removeFromSuperview];
        self.video.transform = CGAffineTransformIdentity;
        self.video.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.video.frame = CGRectMake(0, 0, kDQHeight, kDQWidth);
        self.video.playerLayer.frame = CGRectMake(0, 0, kDQWidth, kDQHeight);
        
        [self.video.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kDQWidth);
            make.height.mas_equalTo(kDQHeight);
            make.left.equalTo(self.video).with.offset(0);
            make.top.equalTo(self.video).with.offset(0);
        }];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.video];
        
        [self setNeedsStatusBarAppearanceUpdate];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.video];
        
    }else{
        [self.video removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        [UIView animateWithDuration:0.5f animations:^{
            self.video.transform = CGAffineTransformIdentity;
            self.video.frame = CGRectMake(0, 160, kDQWidth, 200);
            self.video.playerLayer.frame = self.video.bounds;
            [self.video.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kDQWidth);
                make.height.mas_equalTo(200);
                make.left.equalTo(self.video).with.offset(0);
                make.top.equalTo(self.video).with.offset(0);
                make.right.equalTo(self.video).with.offset(0);
            }];
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.video];
            
        } completion:^(BOOL finished) {
            [self setNeedsStatusBarAppearanceUpdate];
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.video];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationLandscapeRight;
}
@end
