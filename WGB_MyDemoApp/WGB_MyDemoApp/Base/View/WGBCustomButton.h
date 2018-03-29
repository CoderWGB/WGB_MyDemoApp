//
//  WGBCustomButton.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/3/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,WGBCustomButtonType){
	WGBCustomButtonTypeImageTop = 0,
	WGBCustomButtonTypeTitleTop,
	WGBCustomButtonTypeImageLeft,
	WGBCustomButtonTypeTitleLeft,
} ;

IBInspectable
@interface WGBCustomButton : UIButton

@property (nonatomic,strong) IBInspectable UIColor *bgColor; //背景颜色
@property (nonatomic,assign) IBInspectable CGFloat circleArc; //圆角大小
@property (nonatomic,assign) IBInspectable CGFloat borderWidth; //边框宽度
@property (nonatomic,strong) IBInspectable UIColor *borderColor;//边框颜色

@property (nonatomic,assign) IBInspectable NSInteger myButtonType;
@property (nonatomic,assign) IBInspectable CGFloat space;
@property (nonatomic,assign) IBInspectable CGFloat  radius;
@property (nonatomic,assign) IBInspectable  BOOL  buttonHighlighted;
@property (nonatomic,strong) IBInspectable  UIColor *selectedBgColor;
@property (nonatomic,strong) IBInspectable  UIColor *normalBgColor;

@end
