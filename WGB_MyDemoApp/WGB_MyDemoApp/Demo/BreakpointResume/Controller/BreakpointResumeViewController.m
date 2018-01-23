//
//  BreakpointResumeViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/22.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "BreakpointResumeViewController.h"
#import "WGBDownLoadManager.h"

@interface BreakpointResumeViewController ()

@property (strong,nonatomic) UISlider *progressView  ;
@property (strong,nonatomic) UILabel *progressLabel;


@end

@implementation BreakpointResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		self.view.backgroundColor = [UIColor whiteColor];
		[self setup];
//	NSLog(@"%@", [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"totalLength.plist"]);
}

- (void)setup{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.wgb_x = 100;
	button.wgb_y = 120;
	button.wgb_size = CGSizeMake(100, 30);
	[self.view addSubview: button];
	[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor orangeColor];
	[button setTitle:@"开始下载" forState:UIControlStateNormal];
	[button setTitle:@"暂停下载" forState:UIControlStateSelected];

	UISlider *progressView  =[[UISlider alloc] init];
	progressView.value = 0;
	progressView.maximumValue = 1.0;
	progressView.minimumValue = 0.0;
	progressView.tintColor = [UIColor redColor];
	progressView.backgroundColor = [UIColor whiteColor];
	progressView.wgb_size = CGSizeMake(200, 15);
	progressView.wgb_centerX = button.wgb_centerX;
	progressView.wgb_y = button.wgb_bottom + 44;
	[self.view addSubview: progressView];
	self.progressView = progressView;

	UILabel *progressLabel = [[UILabel alloc] init];
	progressLabel.font = [UIFont systemFontOfSize:14];
	progressLabel.textColor = [UIColor redColor];
	progressLabel.wgb_left =  progressView.wgb_right + 15;
	progressLabel.wgb_size = CGSizeMake(60, 21);
	progressLabel.wgb_centerY = progressView.wgb_centerY;
	progressLabel.text = @"0.0%";
	[self.view addSubview: progressLabel];
	self.progressLabel = progressLabel;
}

- (void)buttonAction:(UIButton *)button{
	button.selected = !button.selected;
	if (button.selected == NO) {
		[[WGBDownLoadManager sharedInstance] stopTask];
		return ;
	}
	NSString *downQQURL = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V6.2.1.dmg";
	[[WGBDownLoadManager sharedInstance] downLoadWithURL:downQQURL progress:^(CGFloat progress) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.progressView.value = progress;
			self.progressLabel.text =  [NSString stringWithFormat:@"%.2f%%",progress *100];
		});
	} success:^(NSString *fileStorePath) {
		NSLog(@"\n %@ \n ",fileStorePath);
		dispatch_async(dispatch_get_main_queue(), ^{
			[button setTitle:@"下载完成" forState:UIControlStateNormal];
			kAlertMessage(@"已完成下载任务!");
		});
	} faile:^(NSError *error) {
		NSLog(@"%@",error.domain.description);
	}];
}





@end
