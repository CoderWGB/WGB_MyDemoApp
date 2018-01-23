//
//  NSObject+WGBCreate.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/23.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WGBCreate)
+ (instancetype)wgb_create:(void(^)(id make))block;
- (instancetype)wgb_create:(void(^)(id make))block;
@end
