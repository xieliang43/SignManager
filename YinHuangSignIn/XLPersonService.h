//
//  XLPersonService.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLService.h"
#import "XLPerson.h"

@interface XLPersonService : XLService

- (BOOL)personSignInWithId:(NSInteger)uid;
- (XLPerson *)getPersonById:(NSInteger)uid;
- (NSArray *)getPersonsByKeyWord:(NSString *)keyWord withType:(NSString *)type isSign:(NSString *)sign;
- (BOOL)addPerson:(XLPerson *)person;

@end
