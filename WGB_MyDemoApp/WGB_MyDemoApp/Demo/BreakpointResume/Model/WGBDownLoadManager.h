//
//  WGBDownLoadManager.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/22.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGBDownLoadManager : NSObject<NSURLSessionDataDelegate>

- (void)downLoadWithURL:(NSString *)URL
							progress:(void(^)(CGFloat progress))progressBlock
							 success:(void(^)(NSString *fileStorePath))successBlock
								 faile:(void(^)(NSError *error))faileBlock;

+ (instancetype)sharedInstance;
- (void)stopTask;

@end
