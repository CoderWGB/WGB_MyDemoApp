//
//  QRCodeViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/23.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "QRCodeViewController.h"
#import <LBXScanViewStyle.h>

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];

	UIButton *scanQRCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[scanQRCodeButton wgb_create:^(UIButton *make) {
			make.wgb_x = 100;
			make.wgb_y = 100;
			make.wgb_width = 120;
			make.wgb_height = 30;
			make.backgroundColor = [UIColor cyanColor];
			[make setTitle:@"扫一扫" forState:UIControlStateNormal];
			[make setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
			[make addTarget:self action:@selector(scanQRCodeAction) forControlEvents:UIControlEventTouchUpInside];
	 }];
	[self.view addSubview: scanQRCodeButton];

	UIButton *createQRCodeButton = [UIButton wgb_create:^(UIButton *make) {
		make.wgb_x = 100 ;
		make.wgb_y = 150;
		make.wgb_width = 120;
		make.wgb_height = 30;
		make.backgroundColor = [UIColor orangeColor];
		[make setTitle:@"生成二维码" forState:UIControlStateNormal];
		[make setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
		[make addTarget:self action:@selector(createQRCodeAction) forControlEvents:UIControlEventTouchUpInside];
	}];
	[self.view addSubview: createQRCodeButton];
}

#pragma mark- 打开扫一扫
- (void)scanQRCodeAction{
	LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
	style.centerUpOffset = 44;
	style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
	style.photoframeLineW = 6;
	style.photoframeAngleW = 24;
	style.photoframeAngleH = 24;
	style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;

		//qq里面的线条图片
//	UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
//	style.animationImage = imgLine;

	LBXScanViewController *vc = [LBXScanViewController new];
//	vc.style = style;
//	vc.isQQSimulator = YES;
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- 生成二维码
- (void)createQRCodeAction{


}

@end
