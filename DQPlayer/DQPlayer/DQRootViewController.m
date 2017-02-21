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

#define kDQWidth       ([[UIScreen mainScreen] bounds].size.width)
#define kDQHeight      ([[UIScreen mainScreen] bounds].size.height)


@interface DQRootViewController ()<DQVideoPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) DQVideoPlayerView *video;

@end

@implementation DQRootViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"播放";
    
    self.video = [[DQVideoPlayerView alloc] init];
    self.video.delegate = self;
    
    
    [self loadFiles];
    
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
    //    self.video.frame = CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, 200);//必须指定frame AVPlayerLayer是layer 不可使用autolayout
    [self.view addSubview:self.video];
    
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
    //    [self.video removeFromSuperview];
    //    [self.view addSubview:self.video];
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
    
    //路径问题？？？
    DQVideoModel *model = self.listArray[indexPath.row];
    self.video.netResource = NO;
    self.video.playUrl = model.path;
    [self.video play];
}
#pragma mark - event response

#pragma mark - CustomDelegate

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


@end
