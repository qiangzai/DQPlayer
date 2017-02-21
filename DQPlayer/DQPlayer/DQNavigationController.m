//
//  DQNavigationController.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/21.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  psylife
//  @class DQNavigationController
//  @description <#添加描述#>
//

#import "DQNavigationController.h"

@interface DQNavigationController ()

@end

@implementation DQNavigationController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response

#pragma mark - CustomDelegate

#pragma mark -

#pragma mark - Notification

#pragma mark - private methods(可考虑提取成公用方法)
- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
#pragma mark - setter / getter


@end
