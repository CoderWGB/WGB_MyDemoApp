//
//  WGBCustomNavigationViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/21.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBCustomNavigationViewController.h"

@interface WGBCustomNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WGBCustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self hookPopGestureRecognizer];
}

- (void)hookPopGestureRecognizer{
		// 获取系统自带滑动手势的target对象
	id target = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
		// 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
		// 设置手势代理，拦截手势触发
	pan.delegate = self;
		// 给导航控制器的view添加全屏滑动手势
	[self.view addGestureRecognizer:pan];
		// 禁止使用系统自带的滑动手势
	self.interactivePopGestureRecognizer.enabled = NO;
}

	// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
	// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
		// 注意：只有非根控制器才有滑动返回功能，根控制器没有。
		// 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
	if (self.childViewControllers.count == 1) {
			// 表示用户在根控制器界面，就不需要触发滑动手势，
		return NO;
	}
	return YES;
}


/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
		UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
		leftButton.frame = CGRectMake(0, 0, 60, 44);
		[leftButton setTitle:@"返回" forState:UIControlStateNormal];
		[leftButton setTitleColor:[UIColor blackColor]
										 forState:UIControlStateNormal];
		UIImage *leftButtonImg = [UIImage imageNamed:@"navRuturnBtn"];
		[leftButton setImage: [leftButtonImg imageWithTintColor: [UIColor blackColor]]
								forState:UIControlStateNormal];
		leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
		leftButton.imageEdgeInsets=UIEdgeInsetsMake(0, -5, 0, 0);
		leftButton.titleLabel.font =  [UIFont systemFontOfSize:17];
		[leftButton setAdjustsImageWhenHighlighted:NO];
		[leftButton addTarget:self action:@selector(popLastViewController) forControlEvents:UIControlEventTouchUpInside];
			// 修改导航栏左边的item
		viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
			// 隐藏tabbar
		viewController.hidesBottomBarWhenPushed = YES;
	}
		// 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
	[super pushViewController:viewController animated:animated];
}

- (void)popLastViewController{
	[self popViewControllerAnimated: YES];
}

@end
