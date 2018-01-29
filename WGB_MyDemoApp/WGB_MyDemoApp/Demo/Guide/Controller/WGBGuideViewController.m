//
//  WGBGuideViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBGuideViewController.h"
#import "WGBDebugTouchView.h"

@interface WGBGuideViewController ()

@end

@implementation WGBGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
