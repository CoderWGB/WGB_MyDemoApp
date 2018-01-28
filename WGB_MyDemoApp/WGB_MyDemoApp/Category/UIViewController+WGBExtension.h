//
//  UIViewController+WGBExtension.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WGBExtension)

// 是否禁用右滑pop手势, 默认NO
@property (assign,nonatomic) BOOL rightSwipePopGestureEnable;
	//获取Window当前显示的ViewController
- (UIViewController*)currentViewController ;



@end
