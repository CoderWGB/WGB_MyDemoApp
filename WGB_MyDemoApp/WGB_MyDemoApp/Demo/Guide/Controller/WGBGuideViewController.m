//
//  WGBGuideViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBGuideViewController.h"

@interface WGBGuideViewController ()
@property (strong,nonatomic)UIImageView *imageView;//图像视图
@property (assign,nonatomic)NSInteger index;       //当前图片的索引

@end

@implementation WGBGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"%@",NSStringFromCGRect(self.view.frame));

		//设置当前图片为第一张
	 self.index = 1;
		//初始化图像视图
	self.imageView = [[UIImageView alloc] initWithFrame: [UIScreen mainScreen].bounds];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s%ld",self.index]]];
		//允许图像视图进行用户交互
	self.imageView.userInteractionEnabled = YES;
	[self.view addSubview:self.imageView];

		//创建扫动手势
	UISwipeGestureRecognizer *leftswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
		//设置扫动方向为向左扫
	leftswipe.direction = UISwipeGestureRecognizerDirectionLeft;
		//添加扫动手势
	[self.imageView addGestureRecognizer:leftswipe];

		//创建扫动手势
	UISwipeGestureRecognizer *rightswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
		//设置扫动方向为向右扫
	rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
		//添加扫动手势
	[self.imageView addGestureRecognizer:rightswipe];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.rightSwipePopGestureEnable = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	self.rightSwipePopGestureEnable = NO;
}


#pragma mark -扫动手势
-(void)swipe:(UISwipeGestureRecognizer *)sender
{
		//根据手势的方向改变图片的索引,一共5张图片
	if (sender.direction == UISwipeGestureRecognizerDirectionLeft)//向左扫
			{
		if (self.index >1 )
				{
			self.index--;
				}
		else
				{
			self.index = 5;
				}
			}
	else //向右扫
			{
		if (self.index <5)
				{
			self.index++;
				}
		else
				{
			self.index = 1;
				}
			}
		//使用block函数添加UIView单视图转场动画
	[UIView animateWithDuration:1.0f animations:^{
		[self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s%ld",self.index]]];
	} completion:nil];
}





@end
