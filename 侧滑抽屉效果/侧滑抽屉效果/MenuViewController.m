//
//  MenuViewController.m
//  侧滑抽屉效果
//
//  Created by 王贵彬 on 2018/4/29.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic,strong) UIButton *tempButton;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	 self.view.backgroundColor  =[UIColor blackColor];

	UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[item1 setTitle:@"item1" forState:UIControlStateNormal];
	[item1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[item1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
	item1.tag = 1;
	item1.frame = CGRectMake(0, 100, 180 , 40);
	[self.view addSubview: item1];

	UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[item2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[item2 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
	[item2 setTitle:@"item2" forState:UIControlStateNormal];
	item2.tag = 2;
	item2.frame = CGRectMake(0, 140, 180 , 40);
	[self.view addSubview: item2];

	[item1 addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
	[item2 addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
	item1.selected = YES;
	self.tempButton = item1;
}

- (void)menuSelected:(UIButton *)button{
	self.tempButton.selected = NO;
	button.selected = YES;
	self.tempButton = button;
	if ([self.delegate respondsToSelector:@selector(menuViewController:didSelectItemAtIndex:)]) {
		[self.delegate menuViewController:self didSelectItemAtIndex:button.tag -1];
	}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
