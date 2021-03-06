//
//  UIView+WGBExtra.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/22.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface UIView (WGBExtra)

@property (assign,nonatomic) CGFloat wgb_x;
@property (assign,nonatomic) CGFloat wgb_y;
@property (assign,nonatomic) CGFloat wgb_width;
@property (assign,nonatomic) CGFloat wgb_height;
@property (assign,nonatomic) CGFloat wgb_top;
@property (assign,nonatomic) CGFloat wgb_left;
@property (assign,nonatomic) CGFloat wgb_bottom;
@property (assign,nonatomic) CGFloat wgb_right;

@property (assign,nonatomic) CGSize wgb_size;
@property (assign,nonatomic) CGPoint wgb_origin;
@property (assign,nonatomic) CGFloat wgb_centerX;
@property (assign,nonatomic) CGFloat wgb_centerY;

///响应者接受的视图当前控制器
@property (nullable, nonatomic, readonly, strong) UIViewController *wgb_currentViewController;
///  视图层级最高的控制器
@property (nullable, nonatomic, readonly, strong) UIViewController *wgb_topMostController;

@property (nonatomic,assign) IBInspectable CGFloat arcDegree; //圆角弧度

@end



