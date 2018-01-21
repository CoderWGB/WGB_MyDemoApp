//
//  DemoViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/20.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoModel.h"
#import "WGBDataBaseViewController.h"

@interface DemoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) UITableView *demoTableView ;
@end

@implementation DemoViewController

- (UITableView *)demoTableView{
	if( nil !=_demoTableView){
		return _demoTableView;
	}
	return ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		tableView.delegate = self;
		tableView.dataSource = self;
		tableView.rowHeight = 44;
		tableView.separatorColor = [UIColor blackColor];
		tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		[self.view addSubview: tableView];
		tableView;
	});
}

- (NSMutableArray *)dataSource{
	if(nil != _dataSource){
		return _dataSource;
	}
	_dataSource = [NSMutableArray array];
	return _dataSource;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self createLoacalDataWithDIY];
}

- (void)createLoacalDataWithDIY{
	NSArray *firstRowArray =
		@[
				[DemoModel createWithDemoTitle:@"数据库的相关操作"  description: @"FMDB,sqite3,MySQL..." demoVC: [WGBDataBaseViewController new]],
		];

	[self.dataSource addObject: firstRowArray];
	[self.demoTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSArray *rowArray = [self.dataSource objectAtIndex: section];
	return rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString  * const cellID  = @"WGB_Demo_CellID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
	if(!cell){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;// >
		cell.detailTextLabel.font =[UIFont systemFontOfSize:8];
	}
	DemoModel *demo = self.dataSource[indexPath.section][indexPath.row];
	cell.textLabel.text =  demo.demo_title;
	cell.detailTextLabel.text = demo.desc;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	DemoModel *demo = self.dataSource[indexPath.section][indexPath.row];
  [self.navigationController pushViewController: demo.demoVC  animated: YES];
}




@end
