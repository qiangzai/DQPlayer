//
//  DQRootViewController.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/21.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQRootViewController
//  @description <#添加描述#>
//

#import "DQRootViewController.h"
#import <Masonry.h>
#import "DQVideoPlayerView.h"
#import "DQVideoTableViewCell.h"
#import "DQVideoPlayer.h"
#import "DQVideoView.h"

#import "DQPlayerView.h"
#import "DQPlayerModel.h"
#import "DQPlayerControlView.h"



@interface DQRootViewController ()<DQVideoPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource, DQVideoViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) DQVideoPlayer *videoPlayer;
@property (nonatomic, strong) DQVideoView *videoView;

@property (nonatomic, strong) DQPlayerView *playerView;
@property (nonatomic, strong) DQPlayerModel *playerModel;


@property (nonatomic, strong) UIView *playerFatherView;
@end

@implementation DQRootViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"播放";
    
//    self.video = [[DQVideoPlayerView alloc] init];
//    self.video.delegate = self;
    
    
//    [self loadFiles];
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listTableView.estimatedRowHeight = 80;
    self.listTableView.rowHeight = 80;
    [self.listTableView registerClass:[DQVideoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    self.playerFatherView = [[UIView alloc] init];
////    self.playerFatherView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.playerFatherView];
//    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(64);
////        make.leading.trailing.mas_equalTo(0);
////        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
//        make.size.mas_equalTo(CGSizeMake(kDQWidth, 300));
//        make.left.equalTo(self.view.mas_left);
//    }];
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
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.listArray.count;
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DQVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DQVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    [cell showCellWithModel:self.listArray[indexPath.row]];
    [cell showCellWithModel:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.playerView);
    
    [self.playerView resetToPlayNewVideo:self.playerModel];
    [self.playerView play];
    [self.playerView fullScreenAction];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DQVideoModel *model = self.listArray[indexPath.row];
//    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
//    self.videoPlayer = [[DQVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, kDQWidth, kDQHeight)];
//    self.videoPlayer.urlPath = model.path;
//    self.videoPlayer.transform = CGAffineTransformIdentity;
//    self.videoPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
//    self.videoPlayer.frame = CGRectMake(0, 0, kDQHeight, kDQWidth);
//    self.videoPlayer.playerLayer.frame = CGRectMake(0, 0, kDQWidth, kDQHeight);
//    [[UIApplication sharedApplication].keyWindow addSubview:self.videoPlayer];
//    [self setNeedsStatusBarAppearanceUpdate];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.videoPlayer];
//    
//    self.videoView = [[DQVideoView alloc] initWithFrame:CGRectMake(0, 0, kDQWidth, kDQHeight)];
//    self.videoView.playName = model.name;
//    self.videoView.delegate = self;
//    self.videoView.transform = CGAffineTransformIdentity;
//    self.videoView.transform = CGAffineTransformMakeRotation(M_PI_2);
//    NSLog(@"%@",self.videoView);
//    self.videoView.frame = CGRectMake(0, 0, kDQHeight, kDQWidth);
//    NSLog(@"%@",self.videoView);
//    
//    [[UIApplication sharedApplication].keyWindow insertSubview:self.videoView aboveSubview:self.videoPlayer];
//    
//    [self.videoPlayer play];
//    
//    
//}

#pragma mark - event response

#pragma mark - DQVideoViewDelegate
- (void)playOrPauseButton:(UIButton *)button {
    if (button.selected) {
        [self.videoPlayer play];
    } else {
        [self.videoPlayer pause];
    }
    button.selected = !button.selected;
    
}

- (void)back {
    [self.videoPlayer pause];
    
    
    [self.videoPlayer.player replaceCurrentItemWithPlayerItem:nil];
    
    
    [self.videoView removeFromSuperview];
    [self.videoPlayer removeFromSuperview];
    [self.videoPlayer.playerLayer removeFromSuperlayer];
    self.videoPlayer.player = nil;
    self.videoPlayer.playerItem = nil;
    self.videoPlayer = nil;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}



#pragma mark - DQVideoPlayerDelegate

#pragma mark -

#pragma mark - Notification

#pragma mark - private methods(可考虑提取成公用方法)
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
#pragma mark - setter / getter
- (DQPlayerView *)playerView {
    if (_playerView == nil) {
        _playerView = [[DQPlayerView alloc] init];
        [_playerView playerControlView:nil playerModel:self.playerModel];
    }
    return _playerView;
}

- (DQPlayerModel *)playerModel {
    if (_playerModel == nil) {
        _playerModel = [[DQPlayerModel alloc] init];
        _playerModel.title = @"视频标题";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"QQ20170217-165908.mp4" ofType:nil];
        _playerModel.videoURL = [NSURL fileURLWithPath:path];
//        _playerModel.fatherView = self.playerFatherView;
//        _playerModel.fatherView = self.view;
        _playerModel.fatherView = self.listTableView;
    }
    return _playerModel;
}
@end
