//
//  WGBTabBarViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/21.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBTabBarViewController.h"
#import "WGBCustomNavigationViewController.h"
#import "DemoViewController.h"
#import "BlogListViewController.h"

@interface WGBTabBarViewController ()


@end


@implementation WGBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  	[self createTabSubViewControllers];
		self.tabBar.tintColor = [UIColor blackColor];

		//去掉tabBar顶部线条
	[UITabBar appearance].clipsToBounds = YES;
}

- (void)createTabSubViewControllers{
	///1. DemoVC
	DemoViewController *demoVC = [[DemoViewController alloc] init];
	[self createNavgationViewControllerWithSubViewController: demoVC title: @"WGB_Demo" image:@"jjys_tabbar_ home_normal" selectedImage:@"jjys_tabbar_ home_select"];

		///2. 书架
	BlogListViewController *blogVC = [[BlogListViewController alloc] init];
 [self createNavgationViewControllerWithSubViewController: blogVC title: @"博客列表" image:@"jjys_tabbar_ knowledge_normal" selectedImage:@"jjys_tabbar_ knowledge_select"];

//	UNPostInvitationListViewController *topicVC  = 	[[UNPostInvitationListViewController  alloc] init] ;
//	topicVC.topicType = TopicListTypeDefault ;
//	[self setupController: topicVC   image:@"jjys_tabbar_ order_normal" selectedImage:@"jjys_tabbar_ order_select" title:@"行业交流"];
//
//	[self setupController: [[UNMyCenterViewController alloc] init] image:@"jjys_tabbar_ myprofile_normal" selectedImage:@"jjys_tabbar_ myprofile_select" title:@"我的"];

}

- (void )createNavgationViewControllerWithSubViewController:(UIViewController *)subVC
																											title:(NSString *)title
																											image:(NSString *)image
																							selectedImage:(NSString *)selectedImage{
	WGBCustomNavigationViewController *wgbNavVC = [[WGBCustomNavigationViewController alloc] initWithRootViewController: subVC];
	subVC.navigationItem.title = title;
	subVC.tabBarItem.title = title;
	subVC.tabBarItem.image = [UIImage imageNamed: image];
	subVC.tabBarItem.selectedImage = [[UIImage imageNamed: selectedImage] imageWithTintColor: [UIColor blackColor]];
	[self addChildViewController: wgbNavVC];
}

@end
