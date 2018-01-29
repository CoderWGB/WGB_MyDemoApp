//
//  WGBDebugTouchView.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/28.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBDebugTouchView.h"

	/// 显示状态的key
static NSString * const WGBDebugTouchViewStatusKey = @"WGBDebugTouchViewStatuKey";

@interface WGBDebugTouchView()
	/// closeBtn
@property (nonatomic, readwrite, weak) UIButton *closeBtn;
	/// 开始点
@property (nonatomic, readwrite, assign) CGPoint startPoint;
	/// 是否在动画
@property (nonatomic, readwrite, assign , getter = isAnimated) BOOL animated;

@end


@implementation WGBDebugTouchView

WGBSingletonM(Instance)

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		self.image = [UIImage imageNamed:@"assistivetouch"];
		self.userInteractionEnabled = YES;

			/// 添加tap手势
		[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction:)]];
		UIWindow *window = [UIApplication sharedApplication].keyWindow;
		[window addSubview:self];
		self.wgb_x = [UIScreen mainScreen].bounds.size.width - self.wgb_width - 20;
		self.wgb_y = 84;
		self.hidden = [self isHide];
	}
	return self;
}


- (void)setHide:(BOOL)hide{
	if (self.isAnimated) return;
	[[NSUserDefaults standardUserDefaults] setBool:hide forKey:WGBDebugTouchViewStatusKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	hide?[self close]:[self open];
}

- (BOOL)isHide{
	BOOL temp = [[NSUserDefaults standardUserDefaults] boolForKey:WGBDebugTouchViewStatusKey];
	NSLog(@"++++ Touch View Is Hide %zd ++++" , temp);
	return temp;
}

- (void)open{
		/// 动画开始，禁止交互
	self.userInteractionEnabled = NO;
	self.animated = YES;
	self.hidden = NO;
	self.transform = CGAffineTransformIdentity;
	self.transform = CGAffineTransformMakeScale(.2, .2);
	[UIView animateWithDuration:.25f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.transform = CGAffineTransformMakeScale(1.0, 1.0);
	} completion:^(BOOL finished) {
		self.transform = CGAffineTransformIdentity;
			/// 动画结束，允许交互
		self.userInteractionEnabled = YES;
		self.animated = NO;
	}];
}

- (void)close{
		/// 动画开始，禁止交互
	self.animated = YES;
	self.userInteractionEnabled = NO;
	[UIView animateWithDuration:.25f animations:^{
		self.transform = CGAffineTransformMakeScale(.2, .2);
	} completion:^(BOOL finished) {
		self.transform = CGAffineTransformIdentity;
		self.hidden = YES;
			/// 动画结束，允许交互
		self.userInteractionEnabled = YES;
		self.animated = NO;
	}];
}


#pragma mark - Action
- (void)_tapAction:(UITapGestureRecognizer *)tapGr{
	LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"小提示" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
		if (buttonIndex == 0) {
			return ;
		}
		NSLog(@"%ld-%@",buttonIndex,@[@"打开首页",@"看美女",@"看文章"][buttonIndex-1]);
	} otherButtonTitleArray:@[@"打开首页",@"看美女",@"看文章"]];

	[actionSheet show];
}


#pragma mark - Override
- (void)setFrame:(CGRect)frame{
	frame.size.width = 65;
	frame.size.height = 65;
	[super setFrame:frame];
}

- (void)layoutSubviews{
	[super layoutSubviews];

	CGFloat closeBtnWH = 36;
	self.closeBtn.frame = CGRectMake(self.frame.size.width - closeBtnWH , 0, closeBtnWH, closeBtnWH);
}

#pragma mark - touch move
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
		//保存触摸起始点位置
	CGPoint point = [[touches anyObject] locationInView:self];
	self.startPoint = point;

		//该view置于最前
	[[self superview] bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
		//计算位移=当前位置-起始位置
	CGPoint point = [[touches anyObject] locationInView:self];
	float dx = point.x - self.startPoint.x;
	float dy = point.y - self.startPoint.y;

		//计算移动后的view中心点
	CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);

	/* 限制用户不可将视图托出屏幕 */
	float halfx = CGRectGetMidX(self.bounds);
		//x坐标左边界
	newcenter.x = MAX(halfx, newcenter.x);
		//x坐标右边界
	newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);

		//y坐标同理
	float halfy = CGRectGetMidY(self.bounds);
	newcenter.y = MAX(halfy, newcenter.y);
	newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);

		/// 动画过度
	[UIView animateWithDuration:.25f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
			//移动view
		self.center = newcenter;
	} completion:^(BOOL finished) {

	}];
}

@end
