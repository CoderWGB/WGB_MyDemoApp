//
//  WGBCustomView.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/3/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBCustomView.h"

@implementation WGBCustomView

- (void)setBgColor:(UIColor *)bgColor{
	_bgColor  = bgColor;
	self.backgroundColor = bgColor;
}

- (void)setCircleArc:(CGFloat)circleArc{
	_circleArc = circleArc;
	self.layer.cornerRadius = circleArc;
	self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor{
	_borderColor = borderColor;
	self.layer.borderColor  = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	_borderWidth = borderWidth;
	self.layer.borderWidth = borderWidth;
}
@end
