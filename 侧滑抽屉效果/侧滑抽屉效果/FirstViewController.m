//
//  FirstViewController.m
//  侧滑抽屉效果
//
//  Created by 王贵彬 on 2018/4/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "FirstViewController.h"
#import "ContainerViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"first";
	self.view.backgroundColor = [UIColor orangeColor];
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
