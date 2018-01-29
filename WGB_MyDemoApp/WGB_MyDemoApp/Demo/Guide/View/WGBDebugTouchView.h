//
//  WGBDebugTouchView.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBDebugTouchView : UIImageView
	/// init
WGBSingletonH(Instance);

	/// 设置显示or隐藏
- (void)setHide:(BOOL)hide;
- (BOOL)isHide;

@end
