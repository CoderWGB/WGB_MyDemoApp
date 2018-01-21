//
//  StudentModel.h
//  WGB_MyDemoApp
//
//  Created by 王贵彬 on 2018/1/21.
//  Copyright © 2018年 王贵彬. All rights reserved.
//

#import "BaseModel.h"

@interface StudentModel : BaseModel

@property (assign,nonatomic) int  id ;
@property (copy,nonatomic) NSString *sex ;
@property (copy,nonatomic) NSString *name ;
@property (assign,nonatomic) int age ;

@end
