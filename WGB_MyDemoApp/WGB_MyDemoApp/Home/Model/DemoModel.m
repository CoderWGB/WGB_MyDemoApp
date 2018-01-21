//
//  DemoModel.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/20.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "DemoModel.h"
@implementation DemoModel

- (instancetype)initWithDemoTitle:(NSString *)demo_title
											description:(NSString *)desc
													 demoVC:(UIViewController *)demoVC{
	if(self = [super init]){
		self.demo_title =  demo_title;
		self.desc =  desc;
		self.demoVC = demoVC;
		self.demoVC.navigationItem.title = demo_title;
	}
	return self;
}

+ (instancetype)createWithDemoTitle:(NSString *)demo_title
												description:(NSString *)desc
													demoVC:(UIViewController *)demoVC{
	return [[DemoModel alloc] initWithDemoTitle:demo_title description:desc demoVC: demoVC];
}

@end
