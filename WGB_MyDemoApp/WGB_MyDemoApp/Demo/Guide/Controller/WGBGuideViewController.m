//
//  WGBGuideViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBGuideViewController.h"
#import "WGBDebugTouchView.h"
#import "MHPhotoManager.h"

@interface WGBGuideViewController ()<IDMPhotoBrowserDelegate>

@end

@implementation WGBGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[WGBDebugTouchView sharedInstance]  setClickActionBlcok:^(NSString *title, NSInteger index) {
		if ([title isEqualToString:@"看美女"]) {
			[MHPhotoManager showPhotoBrowser:self photos:
			 @[
				 [IDMPhoto photoWithImage:[UIImage imageNamed:@"s1"]],
				 [IDMPhoto photoWithImage:[UIImage imageNamed:@"s2"]],
				 [IDMPhoto photoWithImage:[UIImage imageNamed:@"s3"]],
				 [IDMPhoto photoWithImage:[UIImage imageNamed:@"s4"]],
				 [IDMPhoto photoWithImage:[UIImage imageNamed:@"s5"]],
				 ] initialPageIndex:0 delegate:self];
		}else 	if ([title isEqualToString:@"打开首页"]) {
			[self.navigationController popToRootViewControllerAnimated:YES];
		}else 	if ([title isEqualToString:@"看文章"]) {\
			self.tabBarController.selectedIndex = 1;
			[self.navigationController popToRootViewControllerAnimated:YES];
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[WGBDebugTouchView sharedInstance] setHide:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[WGBDebugTouchView sharedInstance] setHide:YES];
}


@end
