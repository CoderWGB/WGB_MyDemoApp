//
//  WGBBaseViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/20.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBBaseViewController.h"

@interface WGBBaseViewController ()

@end

@implementation WGBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed: arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
	/// 去除导航栏下方黑线
	[self.navigationController.navigationBar setBackgroundImage: [[UIImage new] imageWithTintColor: [UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
