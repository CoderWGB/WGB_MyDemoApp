//
//  DemoModel.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/20.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface DemoModel : BaseModel

@property (copy,nonatomic) NSString *demo_title ;//标题
@property (copy,nonatomic) NSString *desc ; //说明
@property (strong,nonatomic) UIViewController *demoVC ;


- (instancetype)initWithDemoTitle:(NSString *)demo_title
																		description:(NSString *)desc
													 demoVC:(UIViewController *)demoVC;

+ (instancetype)createWithDemoTitle:(NSString *)demo_title
												description:(NSString *)desc
												demoVC:(UIViewController *)demoVC;


@end
