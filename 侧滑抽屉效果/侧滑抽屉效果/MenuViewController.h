//
//  MenuViewController.h
//  侧滑抽屉效果
//
//  Created by 王贵彬 on 2018/4/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;
@protocol MenuViewControllerDelegate <NSObject>
- (void)menuViewController:(MenuViewController *)menuVC didSelectItemAtIndex:(NSInteger)index ;

@end

@interface MenuViewController : UIViewController
@property (nonatomic,weak) id<MenuViewControllerDelegate> delegate;
@end
