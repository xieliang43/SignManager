//
//  XLPerson.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLModel.h"

@interface XLPerson : XLModel

@property(nonatomic) NSInteger uid;
@property(nonatomic,strong) NSString *prefix;
@property(nonatomic,strong) NSString *acronym;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *type;
@property(nonatomic) NSInteger money;
@property(nonatomic) BOOL isSign;
@property(nonatomic,strong) NSString *picPath;

@end
