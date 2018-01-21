//
//  UIImage+Extension.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/5/22.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

#pragma mark - 创建一张只有背景色的图片
+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return theImage;
}



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
+ (instancetype)imageAddWaterLabel:(UIImage*)image waterText:(NSString*)waterText waterTextDrawPoint:(CGPoint)point andTextAttributes:(NSDictionary*)textDict
{

		//拿到旧图片
	UIImage*oldImage=image;
		//开启上下文
	UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
		//设置绘制图片的起点
	[oldImage drawAtPoint:CGPointZero];

		//新建文本
	NSString * text= waterText;
		//设置文本属性
	NSDictionary *dict = textDict;
		//绘制文本
	[text drawAtPoint:point withAttributes:dict];

		//从上下文中获取新图片
	UIImage *nImage=UIGraphicsGetImageFromCurrentImageContext();
		//关闭上下文
	UIGraphicsEndImageContext();

	return nImage;
}


/**
 * 截屏
 *
 *@参数1: captureView  要截屏的当前视图
 */
+ (instancetype)imageCapture:(UIView*)captureView
{
		//开启上下文
	UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0.0);

		//获取上下文
	CGContextRef tex = UIGraphicsGetCurrentContext();

		//layer只能渲染 不能draw
	[captureView.layer renderInContext:tex];

		//获取截屏图片
	UIImage *nImage =UIGraphicsGetImageFromCurrentImageContext();

		//关闭上下文
	UIGraphicsEndImageContext();

	return nImage;
}


/**
 * 裁剪 边框
 *
 *@参数1: image  原图
 *@参数2: border  边框宽度
 *@参数3: borderColor 边框颜色
 */
+ (instancetype)imageClipBorder:(UIImage*)image border:(CGFloat)border borderColor:(UIColor *)borderColor{
		//设置边框的宽
	CGFloat borderW =border;

		//加载旧图片

	UIImage *oldImage=image;

	CGFloat imageW = oldImage.size.width+2*borderW;
	CGFloat imageH = oldImage.size.height+2*borderW;

	CGFloat ringW = imageW > imageH ? imageH :imageW;

		//    开启上下文
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(ringW, ringW), NO, 0.0);

		//添加外层矩形框
	UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ringW, ringW) cornerRadius:3.0];

		//获取当前上下文
	CGContextRef tex = UIGraphicsGetCurrentContext();

	CGContextAddPath(tex, path.CGPath);

	[borderColor set];
		//渲染

	CGContextFillPath(tex);

	CGRect clipRect =CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);

		//..画一个正切于旧图片的矩形框
	UIBezierPath *clipPath=[UIBezierPath bezierPathWithRoundedRect:clipRect cornerRadius:3.0f];
		//设置裁剪区域
	[clipPath addClip];

		//画图片
	[oldImage drawAtPoint:CGPointMake(borderW, borderW)];

		//生成新图片
	UIImage *nImage=UIGraphicsGetImageFromCurrentImageContext();

		//关闭上下文
	UIGraphicsEndImageContext();


	return nImage;
}



#pragma mark - 指定宽度按比例缩放
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if(CGSizeEqualToSize(imageSize, size) == NO){

        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        if(widthFactor > heightFactor){

            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;

        }else if(widthFactor < heightFactor){

            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)stretchableImage{
    UIImage * image =[self stretchableImageWithLeftCapWidth:self.size.width/2.0f topCapHeight: self.size.height/2.0f ];
    return  image;
}


void ProviderReleaseData (void *info, const void *data, size_t size)
{
	free((void*)data);
}

- (UIImage*) imageBlackToTransparent:(UIImage*) image
{
		// 分配内存
	const int imageWidth = image.size.width;
	const int imageHeight = image.size.height;
	size_t      bytesPerRow = imageWidth * 4;
	uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

		// 创建context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
												 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
	CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

		// 遍历像素
	int pixelNum = imageWidth * imageHeight;
	uint32_t* pCurPtr = rgbImageBuf;
	for (int i = 0; i < pixelNum; i++, pCurPtr++)
	  {
		if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
		  {
			uint8_t* ptr = (uint8_t*)pCurPtr;
			ptr[0] = 0;
		  }
		else
		  {
				// 改成下面的代码，会将图片转成想要的颜色
			uint8_t* ptr = (uint8_t*)pCurPtr;
			ptr[3] = 102; //0~255
			ptr[2] = 51;
			ptr[1] = 0;

		  }

	  }

		// 将内存转成image
	CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
	CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
										kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
										NULL, true, kCGRenderingIntentDefault);
	CGDataProviderRelease(dataProvider);

	UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];

		// 释放
	CGImageRelease(imageRef);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
		// free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free

	return resultUIImage;
}

/*
 kCGBlendModeOverlay,   可以保持背景色的明暗，也就是灰度信息
 kCGBlendModeDestinationIn,  保留透明度信息
 */

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
	return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}


- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
	return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

/**  图像合成 设置边框颜色  */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
	UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
		//填充颜色
	[tintColor setFill];

	CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
	UIRectFill(bounds);

	[self drawInRect:bounds blendMode:blendMode alpha:1.0f];

	if (blendMode != kCGBlendModeDestinationIn) {
		[self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
	}

	UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return tintedImage;
}


/*!
 *  @author  WGB  , 16-04-11 11:04:08
 *
 *  @brief 重新绘制图片的尺寸大小
 *
 *  @param image  图片对象
 *  @param reSize 重新设置尺寸
 *
 *  @return 图片对象
 */
+(UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
		//开启图形上下文
	UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
	/**  绘制图片  */
	[image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
	/**  新尺寸大小的图片  */
	UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return reSizeImage;
}

#pragma mark- 改变图片尺寸
+(UIImage*)changeImageSizeOther:(UIImage*)originImage toSize:(CGSize)size
{
	UIImage* newImage=nil;
	CGSize imageSize=originImage.size;

	CGFloat width=imageSize.width;
	CGFloat height=imageSize.height;
	CGFloat targetWidth=size.width;
	CGFloat targetHeight=size.height;

	CGFloat scaleFactor=0.0;
	CGFloat scaleWidth=targetWidth;
	CGFloat scaleHeight=targetHeight;
	CGPoint thumbnailPoint=CGPointZero;

	if (CGSizeEqualToSize(imageSize, size)==NO)
	  {
		CGFloat widthFacor=targetWidth/width;
		CGFloat heightFactor=targetHeight/height;
		scaleFactor= widthFacor<heightFactor ? widthFacor : heightFactor;
		scaleWidth=width*scaleFactor;
		scaleHeight=height*scaleFactor;
		if (widthFacor<heightFactor)
		  {
			thumbnailPoint.y=(targetHeight-scaleHeight)*0.5;
		  }
		else if (widthFacor>heightFactor)
		  {
			thumbnailPoint.x=(targetWidth-scaleWidth)*0.5;
		  }
	  }
	UIGraphicsBeginImageContext(size);
	CGRect thumbnailRect=CGRectZero;
	thumbnailRect.origin=thumbnailPoint;
	thumbnailRect.size.width=scaleWidth;
	thumbnailRect.size.height=scaleHeight;
	[originImage drawInRect:thumbnailRect];
	newImage=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

	///网络图片根据ImageView控件的宽高来重新定义尺寸
+(UIImage *)getImageFromUrl:(NSURL *)imgUrl imgViewWidth:(CGFloat)width imgViewHeight:(CGFloat)height{
	UIImage * image =[[UIImage alloc] init];
	UIImage * newImage = [image getImageFromUrl:imgUrl imgViewWidth:width imgViewHeight:height];
	return newImage;
}

- (UIImage *)getImageFromUrl:(NSURL *)imgUrl imgViewWidth:(CGFloat)width imgViewHeight:(CGFloat)height{
		//data 转image
	UIImage * image ;
		//根据网址将图片转化成image
	NSData * data = [NSData dataWithContentsOfURL:imgUrl];
	image =[UIImage imageWithData:data];
		//图片剪切
	UIImage * newImage = [self cutImage:image imgViewWidth:width imgViewHeight:height];
	return newImage;
}


	//裁剪图片
- (UIImage *)cutImage:(UIImage*)image imgViewWidth:(CGFloat)width imgViewHeight:(CGFloat)height
{
		//压缩图片
	CGSize newSize;
	CGImageRef imageRef = nil;
	if ((image.size.width / image.size.height) < (width / height)) {
		newSize.width = image.size.width;
		newSize.height = image.size.width * height /width;
		imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
	} else {
		newSize.height = image.size.height;
		newSize.width = image.size.height * width / height;
		imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
	}

	UIImage *img = [UIImage imageWithCGImage:imageRef];
	 CGImageRelease(imageRef);

	return img;

}




@end
