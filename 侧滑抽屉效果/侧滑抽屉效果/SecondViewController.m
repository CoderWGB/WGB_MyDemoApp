//
//  SecondViewController.m
//  侧滑抽屉效果
//
//  Created by 王贵彬 on 2018/4/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "SecondViewController.h"
#import "ContainerViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"second";
	self.view.backgroundColor = [UIColor redColor];
	self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
	self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
	self.navigationController.view.layer.shadowOpacity = 0.15;
	self.navigationController.view.layer.shadowRadius = 10;

	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
	self.navigationItem.leftBarButtonItem = item;
}


- (void)openCloseMenu:(UIBarButtonItem *)item{
	[self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}


@end
