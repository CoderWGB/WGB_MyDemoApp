//
//  UIImage+Extension.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/5/22.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**  生成纯色图片  */
+ (UIImage*)createImageWithColor:(UIColor*)color ;


/**
 * 给图片设置水印
 *
 *@参数1: image  原图
 *@参数2: waterText 水印文字
 *@参数3: point 水印绘制开始的点
 *@参数4: textDict 水印文本属性字典 如:    @{
 NSFontAttributeName :[UIFont systemFontOfSize:15],
 NSForegroundColorAttributeName:[UIColor redColor]
 }
 */
+ (instancetype)imageAddWaterLabel:(UIImage*)image waterText:(NSString*)waterText waterTextDrawPoint:(CGPoint)point andTextAttributes:(NSDictionary*)textDict;

/**
 * 截屏
 *
 *@参数1: captureView  要截屏的当前视图
 */
+ (instancetype)imageCapture:(UIView*)captureView ;


/**
 * 裁剪 边框
 *
 *@参数1: image  原图
 *@参数2: border  边框宽度
 *@参数3: borderColor 边框颜色
 */
+ (instancetype)imageClipBorder:(UIImage*)image border:(CGFloat)border borderColor:(UIColor *)borderColor ;




#pragma mark - 指定宽度按比例缩放
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth ;

//拉伸图片
- (UIImage *)stretchableImage;


- (UIImage*) imageBlackToTransparent:(UIImage*) image;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

+(UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
#pragma mark- 改变图片尺寸
+(UIImage*)changeImageSizeOther:(UIImage*)originImage toSize:(CGSize)size;


	///网络图片根据ImageView控件的宽高来重新定义尺寸
+(UIImage *)getImageFromUrl:(NSURL *)imgUrl imgViewWidth:(CGFloat)width imgViewHeight:(CGFloat)height;



@end
