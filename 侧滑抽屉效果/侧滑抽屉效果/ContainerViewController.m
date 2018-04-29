//
//  ContainerViewController.m
//  侧滑抽屉效果
//
//  Created by 王贵彬 on 2018/4/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ContainerViewController ()<MenuViewControllerDelegate>
@property (nonatomic,strong) MenuViewController *menuVC;
@property (nonatomic,strong) UIViewController *currentVC;
@property (nonatomic,strong) NSArray *viewControllers;
@property (nonatomic,assign) BOOL isMenuOpen;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) BOOL isAnimationing;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	  [self addMenuVC];
  	[self addChildVCs];

}

- (void)addMenuVC{
	MenuViewController *menuVC = [[MenuViewController alloc] init];
	[self.view addSubview: menuVC.view];
	[self addChildViewController: menuVC];
	menuVC.delegate = self;
	self.selectIndex = 0;
	self.menuVC  =  menuVC;
}
- (void)addChildVCs{
	FirstViewController *firstVC = [[FirstViewController alloc] init];
	UINavigationController *firstNvc  = [[UINavigationController alloc ] initWithRootViewController: firstVC];
	SecondViewController *secondVC = [[SecondViewController alloc] init];
	UINavigationController *secondNvc  = [[UINavigationController alloc ] initWithRootViewController: secondVC];
	self.viewControllers = @[firstNvc,secondNvc];
	self.currentVC = firstNvc;
}

- (void)setCurrentVC:(UIViewController *)currentVC{
	if (_currentVC == currentVC) {
		return ;
	}
	if (_currentVC) {
		currentVC.view.transform = _currentVC.view.transform;
	}

	[_currentVC willMoveToParentViewController:nil];
	[_currentVC.view removeFromSuperview];
	[_currentVC removeFromParentViewController];

	_currentVC  =  currentVC;
	[self addChildViewController: currentVC];
	[self.view addSubview: currentVC.view];
}

- (void)openCloseMenu{
	if (self.isAnimationing) {
		return ;
	}

	[UIView animateWithDuration:0.25 animations:^{
		self.isAnimationing = YES;
		if (!self.isMenuOpen) {
			self.currentVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.view.bounds) - 64, 0);
		}else{
			self.currentVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.view.bounds), 0);

		}
	} completion:^(BOOL finished) {
		self.isMenuOpen = !self.isMenuOpen;
		self.currentVC = self.viewControllers[self.selectIndex];
		if (!self.isMenuOpen) {
			[UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
				self.currentVC.view.transform = CGAffineTransformIdentity;
			} completion:^(BOOL finished) {
				self.isAnimationing = NO;
			}];
		}else{
			self.isAnimationing = NO;
		}
	}];
}

#pragma mark- <MenuViewControllerDelegate>
- (void)menuViewController:(MenuViewController *)menuVC didSelectItemAtIndex:(NSInteger)index{
	self.selectIndex = index;
	[self openCloseMenu];
}


@end
