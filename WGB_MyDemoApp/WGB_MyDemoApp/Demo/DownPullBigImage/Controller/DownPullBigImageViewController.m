//
//  DownPullBigImageViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/2/13.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "DownPullBigImageViewController.h"
#import "WGBBigImageHeader.h"

@interface DownPullBigImageViewController ()

@end

@implementation DownPullBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.navigationController.navigationBar.hidden = YES ;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.edgesForExtendedLayout = UIRectEdgeNone ;
	self.tableView.tableHeaderView = [UIView new];
	self.tableView = [self.tableView initWithFrame:self.tableView.bounds style:UITableViewStylePlain] ;
	self.view.backgroundColor = [UIColor colorWithRed: arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
	self.tableView.tableFooterView = [UIView new];
	WGBBigImageHeader *header = [[WGBBigImageHeader alloc] initWithFrame: CGRectMake(0, 0, kWidth, 150) minHeight: 150];
	header.backgroundColor = [UIColor redColor];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s1"]];
	imageView.frame = header.bounds;
	imageView.contentMode = UIViewContentModeScaleAspectFill |
	UIViewContentModeTop|  UIViewContentModeTopLeft|
	UIViewContentModeTopRight;
	imageView.clipsToBounds = YES;
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
	[header addSubview: imageView];
	[self.view addSubview: header];
	[self.view sendSubviewToBack: header];
}



@end
