//
//  WGBDataBaseViewController.m
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/20.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "WGBDataBaseViewController.h"

@interface WGBDataBaseViewController ()

@property (strong,nonatomic) FMDatabase *db ;
@property (strong,nonatomic) FMDatabaseQueue *queue ;

@property (strong,nonatomic) UITextView *textView ;
@property (strong,nonatomic) NSMutableString *logMessage ;


@end

@implementation WGBDataBaseViewController

- (NSMutableString *)logMessage{
	if(!_logMessage){
		_logMessage = [NSMutableString string];
	}
	return _logMessage;
}

- (UITextView *)textView{
	if(!_textView){
		_textView = [[UITextView alloc] init];
		_textView.editable = NO;
		_textView.textColor = [UIColor redColor];
		_textView.backgroundColor = [UIColor cyanColor];
		_textView.text = @"查询结果...";
		_textView.layoutManager.allowsNonContiguousLayout = NO;
		[self.view addSubview: _textView];
	}
	return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
/// 创建增删改查按钮
	CGRect frame = CGRectMake(100, 75, 100, 30);
	CGFloat space = 44;
 [self addButtonWithFrame: frame buttonTitle: @"插入数据"];
	frame.origin.y += space;
	[self addButtonWithFrame: frame buttonTitle: @"删除数据"];
	frame.origin.y += space;
	[self addButtonWithFrame: frame buttonTitle: @"更新数据"];
	frame.origin.y += space;
	[self addButtonWithFrame: frame buttonTitle: @"查询数据"];
	frame.origin.y += space;
	[self addButtonWithFrame: frame buttonTitle: @"一键清屏"];
	CGFloat textY = frame.origin.y + space*2;
	self.textView.frame = CGRectMake(0,textY, kWidth, kHeight - textY);

	/// 创建表
	[self createTabMethod001];
	[self searchDataAction];
}

- (void)createTabMethod001{
		//1.获得数据库文件的路径
	NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
	NSString *fileName = [doc stringByAppendingPathComponent: @"student.sqlite"];
	NSLog(@"%@",fileName);
		//2.获得数据库
	FMDatabase *db = [FMDatabase databaseWithPath: fileName];
	self.db = db;
	//3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
	if ([db open])
		{
		//4.创表
	BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL,sex text NOT NULL);"];
	if (result)
				{
			NSLog(@"创建表成功");
			[self.logMessage appendFormat:@"\n大吉大利,创建表成功或者打开成功!\t\n"];
			[self displayLogMessage];
			}
		}
}

- (void)createMethod002{
	NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
	NSString *fileName = [doc stringByAppendingPathComponent: @"student.sqlite"];
	NSLog(@"filename%@",fileName);
		// 1.创建数据库队列
	self.queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
		// 2.创表
	[self.queue inDatabase:^(FMDatabase *db) {
		/// 创建表的语句 大致意思是主键id自增长 存储姓名和年龄 再加个性别吧
		BOOL result = [db executeUpdate:@"create table if not exists t_student (id integer primary key autoincrement, name text, age integer,sex text);"];
		if (result) {
			NSLog(@"创表成功");
		} else {
			NSLog(@"创表失败");
		}
	}];
}

#pragma mark- 插入数据
- (void)addDataAction{
	int age = arc4random() % 40;
	NSString *xing = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王"][arc4random()%8];
	NSString *subName = @[@"二狗子",@"铁柱",@"英男",@"杰伦",@"彦祖",@"德华",@"青山",@"绿水",@"狗蛋",@"狗剩"][arc4random()%10];
	NSString *name =  [NSString stringWithFormat:@"%@%@",xing,subName];
	NSString *sex = @[@"男",@"女"][arc4random()%2] ;
		//1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
	[self.db executeUpdate:@"INSERT INTO t_student (name,age,sex) VALUES (?,?,?);",name,@(age),sex];
	NSLog(@"成功插入一条新数据:\t %@-%@-%@",name,@(age),sex);
	[self.logMessage appendFormat:@"\n成功插入一条新数据!\t %@-%@-%@ \t\n",name,@(age),sex];
	[self displayLogMessage];

		//2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//	[self.db executeUpdateWithFormat:@"insert into t_student (name,age,sex) values (%@,%i,%@);",name,age,sex];
//
//		//3.参数是数组的使用方式
//	[self.db executeUpdate:@"INSERT INTO  t_student(name,age,sex) VALUES  (?,?);" withArgumentsInArray:@[name,@(age),sex]];
}

#pragma mark- 删除数据
- (void)deleteDataAction{
		//1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
	FMResultSet *resultSet = [self.db executeQuery:@"select * from t_student;"];
	NSMutableArray *ageArray = [NSMutableArray array];
	while ([resultSet next]) {
		int ageArg = [resultSet intForColumn:@"age"];
		[ageArray addObject:@(ageArg)];
	}
	///从原有数据中取随机岁数抽取 类似于抽奖,看看谁会成为幸运儿呢 哈哈哈哈嗝😄
	if	(!ageArray.count){
		[self.logMessage appendFormat:@"\n数据库无数据项,请先插入数据再操作!!!\t  \t\n"];
		self.textView.text = self.logMessage;
		return ;
	}
		NSInteger age = [ageArray[arc4random() % ageArray.count] integerValue];
		[self.db executeUpdate: @"delete from t_student where age = ?;",@(age)];
		[self.logMessage appendFormat:@"\n成功删除年龄为%@岁的数据!\t  \t\n",@(age)];
	[self displayLogMessage];

		//2.不确定的参数用%@，%d等来占位  二狗这个太难听了 凡是含有二狗的全部刷掉  于是模糊查询 delete 这些
//	[self.db executeUpdateWithFormat:@"delete from t_student where name like '%二狗%';"];

}

#pragma mark- 修改数据
- (void)updateDataAction{
		//修改学生的名字  查询到 0岁的 设置成18岁 限制条件是你数据库里要有0岁的数据先
	// 于是
	FMResultSet *resultSet = [self.db executeQuery:@"select * from t_student;"];
	NSMutableArray *ageArray = [NSMutableArray array];
	while ([resultSet next]) {
		int ageArg = [resultSet intForColumn:@"age"];
		[ageArray addObject:@(ageArg)];
	}
		///从原有数据中取随机岁数抽取 类似于抽奖,看看谁会成为幸运儿呢 哈哈哈哈嗝😄
	if	(!ageArray.count || ![ageArray containsObject:@(0)]){
		[self.logMessage appendFormat:@"\n数据库为空或者无该数据项,请先插入数据再操作!!!\t  \t\n"];
		self.textView.text = self.logMessage;
		return ;
	}
	[self.db executeUpdate:@"update t_student set age = ? where age = ?",@(18),@(0)];
	[self.logMessage appendFormat:@"\n成功将年龄为0岁的数据修改成了18岁!\t  \t\n"];
	[self displayLogMessage];
}

#pragma mark- 查询数据
- (void)searchDataAction{
		//	表达式(精确查找用”=“,模糊查找用like)
		//	select * from student where number like 1
		//查询整个表
	FMResultSet *resultSet = [self.db executeQuery:@"select * from t_student;"];
		//根据条件查询  模糊查询包含"二狗"的数据项
//	FMResultSet *resultSet = [self.db executeQuery:@"select * from t_student where  name  like '%二狗%';"];
		//遍历结果集合
	[self.logMessage appendString:@"\n\n\n\t 学生表(t_student)的所有数据如下:  \t\n"];
	[self.logMessage appendString:@"\n\t主键\t\t姓名\t\t年龄\t\t性别 \t\n"];
	while ([resultSet  next]){
			int idNum = [resultSet intForColumn:@"id"];
			NSString *name = [resultSet 	objectForColumnName:@"name"];
			int age = [resultSet intForColumn:@"age"];
		NSString *sex = [resultSet objectForColumnName:@"sex"];
		NSString *log = [NSString stringWithFormat:@"%@\t\t%@\t\t%@\t\t%@",@(idNum),name,@(age),sex];
		[self.logMessage appendFormat:@"\n\t%@\t\n",log];
		}
	[self displayLogMessage];
}

///清空日志
- (void)clearAllLogMessage{
	self.textView.text = nil;
	self.logMessage = nil;
	[self.logMessage appendString: @"数据库已准备就绪..."];
}

/// 显示滚到最后一行
- (void)displayLogMessage{
	self.textView.text = self.logMessage;
	[self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

- (void)buttonClick:(UIButton *)button{
	if([button.currentTitle isEqualToString:@"插入数据"]){
		[self addDataAction];
	}else 	if([button.currentTitle isEqualToString:@"删除数据"]){
		[self deleteDataAction];
	}else 	if([button.currentTitle isEqualToString:@"更新数据"]){
		[self updateDataAction];
	}else 	if([button.currentTitle isEqualToString:@"查询数据"]){
		[self searchDataAction];
	}else 	if([button.currentTitle isEqualToString:@"一键清屏"]){
		[self clearAllLogMessage];
	}
}

- (void)addButtonWithFrame:(CGRect)frame  buttonTitle:(NSString *)buttonTitle{
	UIButton *button  =[UIButton buttonWithType: UIButtonTypeCustom];
	button.backgroundColor = [UIColor orangeColor];
	[button setTitle:buttonTitle  forState:UIControlStateNormal];
	[button setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
	button.frame = frame;
	[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: button];
}

@end
