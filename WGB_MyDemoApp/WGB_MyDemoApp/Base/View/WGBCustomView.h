//
//  WGBCustomView.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/3/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WGBCustomView : UIView

@property (nonatomic,strong) IBInspectable UIColor *bgColor; //背景颜色
@property (nonatomic,assign) IBInspectable CGFloat circleArc; //圆角大小
@property (nonatomic,assign) IBInspectable CGFloat borderWidth; //边框宽度
@property (nonatomic,strong) IBInspectable UIColor *borderColor;//边框颜色

@end
