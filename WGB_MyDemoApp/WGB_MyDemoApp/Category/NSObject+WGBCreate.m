//
//  NSObject+WGBCreate.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/23.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "NSObject+WGBCreate.h"

@implementation NSObject (WGBCreate)
+ (instancetype)wgb_create:(void(^)(id make))block{
	id  instance = [[self alloc] init];
	block(instance);
	return instance;
}
- (instancetype)wgb_create:(void(^)(id make))block{
	block(self);
	return self;
}

@end
