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
#import "DQVideoTableViewCell.h"

#import "DQPlayerView.h"
#import "DQPlayerModel.h"
#import "DQPlayerControlView.h"



@interface DQRootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
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



#pragma mark - event response



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
