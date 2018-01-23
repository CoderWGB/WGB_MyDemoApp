//
//  UIView+WGBExtra.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/22.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "UIView+WGBExtra.h"

@implementation UIView (WGBExtra)

- (CGFloat)wgb_x{
	return self.frame.origin.x;
}
- (CGFloat)wgb_y{
	return self.frame.origin.y;
}
- (CGFloat)wgb_width{
	return self.frame.size.width;
}
- (CGFloat)wgb_height{
	return self.frame.size.height;
}
- (void)setWgb_x:(CGFloat)wgb_x{
	CGRect frame = self.frame;
	frame.origin.x = wgb_x;
	self.frame = frame;
}
- (void)setWgb_y:(CGFloat)wgb_y{
	CGRect frame = self.frame;
	frame.origin.y = wgb_y;
	self.frame = frame;
}
- (void)setWgb_width:(CGFloat)wgb_width{
	CGRect frame = self.frame;
	frame.size.width = wgb_width;
	self.frame = frame;
}
- (void)setWgb_height:(CGFloat)wgb_height{
	CGRect frame = self.frame;
	frame.size.height = wgb_height;
	self.frame = frame;
}
- (CGFloat)wgb_top{
	return self.wgb_y;
}
- (CGFloat)wgb_left{
	return self.wgb_x;
}
- (CGFloat)wgb_bottom{
	return self.wgb_top + self.wgb_height;
}
- (CGFloat)wgb_right{
	return self.wgb_left + self.wgb_width;
}
- (void)setWgb_top:(CGFloat)wgb_top{
	CGRect frame = self.frame;
	frame.origin.y = wgb_top;
	self.frame = frame;
}
- (void)setWgb_left:(CGFloat)wgb_left{
	CGRect frame = self.frame;
	frame.origin.x = wgb_left;
	self.frame = frame;
}
- (void)setWgb_bottom:(CGFloat)wgb_bottom{
	CGRect frame = self.frame;
	frame.origin.y = wgb_bottom - self.wgb_height;
	self.frame = frame;
}
- (void)setWgb_right:(CGFloat)wgb_right{
	CGRect frame = self.frame;
	frame.origin.x = wgb_right - self.wgb_width;
	self.frame = frame;
}
- (CGFloat)wgb_centerX{
	return self.center.x;
}
- (CGFloat)wgb_centerY{
	return self.center.y;
}
- (void)setWgb_centerX:(CGFloat)wgb_centerX{
	CGPoint center = self.center;
	center.x = wgb_centerX;
	self.center = center;
}
- (void)setWgb_centerY:(CGFloat)wgb_centerY{
	CGPoint center = self.center;
	center.y = wgb_centerY;
	self.center = center;
}

- (CGSize)wgb_size{
	return self.frame.size;
}
- (void)setWgb_size:(CGSize)wgb_size{
	CGRect frame = self.frame;
	frame.size = wgb_size;
	self.frame = frame ;
}
- (CGPoint)wgb_origin{
	return self.frame.origin;
}
- (void)setWgb_origin:(CGPoint)wgb_origin{
	CGRect frame = self.frame;
	frame.origin = wgb_origin;
	self.frame = frame;
}

@end
