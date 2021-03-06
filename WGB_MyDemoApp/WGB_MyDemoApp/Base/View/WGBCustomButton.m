//
//  WGBCustomButton.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/3/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBCustomButton.h"

@implementation WGBCustomButton
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

- (void)setSpace:(CGFloat)space{
	_space = space;
	[self layoutIfNeeded];
	[self setNeedsLayout];
}

/**  IB不能设置枚举类型    可以用NSNumber来替代  */
- (void)setMyButtonType:(NSInteger)myButtonType{
	_myButtonType = myButtonType;

	CGFloat imageWith = self.imageView.frame.size.width;
	CGFloat imageHeight = self.imageView.frame.size.height;

	CGFloat labelWidth = 0.0;
	CGFloat labelHeight = 0.0;
	if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
			// 由于iOS8中titleLabel的size为0，用下面的这种设置
		labelWidth = self.titleLabel.intrinsicContentSize.width;
		labelHeight = self.titleLabel.intrinsicContentSize.height;
	} else {
		labelWidth = self.titleLabel.frame.size.width;
		labelHeight = self.titleLabel.frame.size.height;
	}

	UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
	UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;

	CGFloat space =self.space;

	switch (myButtonType) {// 设置按钮内容的位置
		case WGBCustomButtonTypeImageTop: //图片在上
			{
		space = 10;
		imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
		labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
			}
			break;
		case WGBCustomButtonTypeImageLeft://图片在左
			{
		imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
		labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
			}
			break;
		case WGBCustomButtonTypeTitleTop://标题在上
			{
		imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
		labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
			}
			break;
		case WGBCustomButtonTypeTitleLeft://标题在左
			{
		imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
		labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
			}
			break;
		default:
			break;
	}
		// 4. 赋值
	self.titleEdgeInsets = labelEdgeInsets;
	self.imageEdgeInsets = imageEdgeInsets;
}


/**  按钮是否需要高亮属性?  */
- (void)setButtonHighlighted:(BOOL)buttonHighlighted{
	_buttonHighlighted = buttonHighlighted;
}

- (void)setHighlighted:(BOOL)highlighted{
	/**  交给IB去设置  */
	if (self.buttonHighlighted) {
		[super setHighlighted: self.buttonHighlighted];
	}else{
		[super setHighlighted:highlighted];
	}
}

- (void)setSelectedBgColor:(UIColor *)selectedBgColor{
	_selectedBgColor = selectedBgColor;
	[self setBackgroundImage:[UIImage createImageWithColor:selectedBgColor] forState:UIControlStateSelected];
}

- (void)setNormalBgColor:(UIColor *)normalBgColor{
	_normalBgColor = normalBgColor;
	[self setBackgroundImage:[UIImage createImageWithColor:normalBgColor] forState:UIControlStateNormal];
}


@end
