//
//  UIViewController+WGBExtension.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "UIViewController+WGBExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (WGBExtension)

- (void)setRightSwipePopGestureEnable:(BOOL)rightSwipePopGestureEnable{
	objc_setAssociatedObject(self, @selector(setRightSwipePopGestureEnable:), @(rightSwipePopGestureEnable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)rightSwipePopGestureEnable{
	return  objc_getAssociatedObject(self, _cmd);
}


	//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
		//获得当前活动窗口的根视图
	UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
	while (1)
			{
			//根据不同的页面切换方式，逐步取得最上层的viewController
		if ([vc isKindOfClass:[UITabBarController class]]) {
			vc = ((UITabBarController*)vc).selectedViewController;
		}
		if ([vc isKindOfClass:[UINavigationController class]]) {
			vc = ((UINavigationController*)vc).visibleViewController;
		}
		if (vc.presentedViewController) {
			vc = vc.presentedViewController;
		}else{
			break;
		 }
		}
	return vc;
}


@end
