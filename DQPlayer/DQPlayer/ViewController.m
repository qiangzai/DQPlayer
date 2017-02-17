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
#import "DQVideoTableViewCell.h"

#define kDQWidth       ([[UIScreen mainScreen] bounds].size.width)
#define kDQHeight      ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<DQVideoPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
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
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testvide.mp4" ofType:nil];
    self.video.playUrl = videoPath;
    [self.video play];
    
//    [self loadFiles];
//    
//    self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.listTableView.dataSource = self;
//    self.listTableView.delegate = self;
//    self.listTableView.estimatedRowHeight = 80;
//    self.listTableView.rowHeight = 80;
//    [self.listTableView registerClass:[DQVideoTableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.view addSubview:self.listTableView];
//    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DQVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DQVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell showCellWithModel:self.listArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.video.frame = CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, 200);//必须指定frame AVPlayerLayer是layer 不可使用autolayout
    [self.view addSubview:self.video];
    
    
    
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
//    
//    [self.video removeFromSuperview];
//    [self.view addSubview:self.video];
//    self.video.transform = CGAffineTransformIdentity;
//    self.video.transform = CGAffineTransformMakeRotation(M_PI_2);
//    self.video.frame = CGRectMake(0, 0, kDQHeight, kDQWidth);
//    self.video.playerLayer.frame = CGRectMake(0, 0, kDQWidth, kDQHeight);
//    
//    [self.video.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(kDQWidth);
//        make.height.mas_equalTo(kDQHeight);
//        make.left.equalTo(self.video).with.offset(0);
//        make.top.equalTo(self.video).with.offset(0);
//    }];
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.video];
//    
//    [self setNeedsStatusBarAppearanceUpdate];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.video];
    
//    //路径问题？？？
//    DQVideoModel *model = self.listArray[indexPath.row];
//    self.video.playUrl = model.path;
//    [self.video play];
//    [self test:nil];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testvide.mp4" ofType:nil];
    self.video.playUrl = videoPath;
    [self.video play];
    
    
}

#pragma mark - private methods
- (void)loadFiles {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSError *error = nil;
    //假如存在多级文件夹  如何处理？
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *nameArr = [manager contentsOfDirectoryAtPath:documentsPath error:&error];
    for (int i = 0; i < nameArr.count; i ++) {
        NSString *path = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",nameArr[i]]];
        NSDictionary *dict = [manager attributesOfItemAtPath:path error:&error];
        NSMutableDictionary *fileDict = [[NSMutableDictionary alloc] init];
        [fileDict setObject:path forKey:@"path"];
        [fileDict setObject:dict[@"NSFileSize"] forKey:@"size"];
        [fileDict setObject:nameArr[i] forKey:@"name"];
        DQVideoModel *model = [[DQVideoModel alloc] initWithDictionary:fileDict];
        [array addObject:model];
    }
    
    self.listArray = array;
    [self.listTableView reloadData];
    
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
