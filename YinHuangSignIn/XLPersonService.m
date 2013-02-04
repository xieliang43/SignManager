//
//  XLPersonService.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLPersonService.h"

@implementation XLPersonService

- (BOOL)personSignInWithId:(NSInteger)uid
{
    BOOL result = NO;
    
    if (![fmdb open]) {
        NSLog(@"could not open db.");
        return NO;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    NSString *sql = [NSString stringWithFormat:@"update d_person_sign_info set is_sign = '1' where id = %d",uid];
    result = [fmdb executeUpdate:sql];
    
    [fmdb close];
    
    return result;
}

- (XLPerson *)getPersonById:(NSInteger)uid
{
    XLPerson *person = [[XLPerson alloc] init];
    
    if (![fmdb open]) {
        NSLog(@"could not open db.");
        return NO;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    NSString *sql = [NSString stringWithFormat:@"select * from d_person_sign_info where id = %d",uid];
    FMResultSet *rs = [fmdb executeQuery:sql];
    while ([rs next]) {
        person.uid = [rs intForColumn:@"id"];
        person.prefix = [rs stringForColumn:@"prefix"];
        person.acronym = [rs stringForColumn:@"acronym"];
        person.name = [rs stringForColumn:@"name"];
        person.type = [rs stringForColumn:@"type"];
        person.money = [rs intForColumn:@"money"];
        person.isSign = [rs boolForColumn:@"is_sign"];
        person.picPath = [rs stringForColumn:@"pic"];
    }
    
    [rs close];
    [fmdb close];
    
    return person;
}

- (NSArray *)getPersonsByKeyWord:(NSString *)keyWord withType:(NSString *)type isSign:(NSString *)sign
{
    NSMutableArray *personArr = [[NSMutableArray alloc] init];
    
    if (![fmdb open]) {
        NSLog(@"could not open db.");
        return NO;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select * from d_person_sign_info where 1 = 1"];
    
    if (keyWord) {
        [sql appendFormat:@" and (acronym like '%%%@%%' or name like '%%%@%%')",keyWord,keyWord];
    }
    
    if (type) {
        [sql appendFormat:@" and type = '%@'",type];
    }
    
    if (sign) {
        [sql appendFormat:@" and is_sign = '%@'",sign];
    }
    
    [sql appendString:@" order by prefix,acronym,name"];
    
    FMResultSet *rs = [fmdb executeQuery:sql];
    while ([rs next]) {
        XLPerson *person = [[XLPerson alloc] init];
        
        person.uid = [rs intForColumn:@"id"];
        person.prefix = [rs stringForColumn:@"prefix"];
        person.acronym = [rs stringForColumn:@"acronym"];
        person.name = [rs stringForColumn:@"name"];
        person.type = [rs stringForColumn:@"type"];
        person.money = [rs intForColumn:@"money"];
        person.isSign = [rs boolForColumn:@"is_sign"];
        person.picPath = [rs stringForColumn:@"pic"];
        
        [personArr addObject:person];
    }
    
    [rs close];
    [fmdb close];
    
    return personArr;
}

- (BOOL)addPerson:(XLPerson *)person
{
    if (![fmdb open]) {
        NSLog(@"could not open db.");
        return NO;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    NSString *string = [NSString stringWithFormat:@"insert into d_person_sign_info(prefix,acronym,name,type,money,is_sign,pic) values ('%@','%@','%@','%@',0,'0','%@')",person.prefix,person.acronym,person.name,person.type,person.picPath];
    BOOL result = [fmdb executeUpdate:string];
    
    [fmdb close];
    return result;
}

@end
