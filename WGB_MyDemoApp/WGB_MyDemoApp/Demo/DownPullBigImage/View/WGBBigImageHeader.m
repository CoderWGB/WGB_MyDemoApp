//
//  WGBBigImageHeader.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/2/13.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBBigImageHeader.h"
@interface WGBBigImageHeader()
@property (assign,nonatomic) CGFloat minHeight;
@end

@implementation WGBBigImageHeader


- (instancetype)initWithFrame:(CGRect)frame minHeight:(CGFloat)minHeight{
	if (self = [super initWithFrame: frame]) {
		self.minHeight = minHeight;
	}
	return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
	[super willMoveToSuperview:newSuperview];
	[self.superview removeObserver:self forKeyPath:@"contentOffset"];
	if (!newSuperview) {
		NSAssert([newSuperview isKindOfClass:[UIScrollView class]], @"superView must be UIScrollView");
	}
	CGRect newFrame = self.frame;
	newFrame.size.width = newSuperview.frame.size.width;
	self.frame = newFrame;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

		// 监听contentOffset
	[newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
	if ([keyPath isEqualToString:@"contentOffset"]) {
		UIScrollView *scrollView = (UIScrollView *)self.superview;
		CGFloat delta = 0;
		if (scrollView.contentOffset.y < 0) {
			delta = ABS(MIN(0, scrollView.contentOffset.y));
		}
		CGRect frame = self.frame;
		frame.origin.y = - delta;
		frame.size.height = self.minHeight + delta;
		self.frame = frame;
	}else{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}
@end
