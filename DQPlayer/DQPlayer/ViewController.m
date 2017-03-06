//
//  ViewController.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/16.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
   
}

- (BOOL)isTrueUrl:(NSString *)url {
    NSString *regex = @"^((https|http|ftp|rtsp|mms)?://)?(([0-9a-zA-Z_!~*'().&=+$%-]+: )?[0-9a-zA-Z_!~*'().&=+$%-]+@)?(([0-9]{1,3}\\.){3}[0-9]{1,3}|(\\[([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[[0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4}\\](:[1-9]([0-9]){0,4})?)|(\\[([0-9A-Fa-f]{1,4}:){1,7}:\\](:[1-9]([0-9]){0,4})?)|([0-9a-zA-Z_!~*'()-]+\\.)*([0-9a-zA-Z][0-9a-zA-Z-]{0,61})?[0-9a-zA-Z]\\.[a-zA-Z]{2,6})(:[0-9]{1,4})?((/?)|(/[0-9a-zA-Z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:url];
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
