//
//  XLTools.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLTools.h"

@implementation XLTools

+ (NSString *)documentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)filePathWithName:(NSString *)name
{
    return [NSString stringWithFormat:@"%@/%@",[XLTools documentsPath],name];
}

@end
