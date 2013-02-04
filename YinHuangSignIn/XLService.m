//
//  XLService.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLService.h"

@implementation XLService

- (id)init
{
    self = [super init];
    if (self) {
        fmdb = [FMDatabase databaseWithPath:[XLDBTools dbFilePath]];
    }
    return self;
}

@end
