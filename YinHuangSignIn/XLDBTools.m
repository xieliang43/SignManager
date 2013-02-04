//
//  XLDBTools.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLDBTools.h"

@implementation XLDBTools

+ (NSString *)dbFilePath
{
    return [NSString stringWithFormat:@"%@/dbfile.sqlite",[XLTools documentsPath]];
}

+ (BOOL)copyDBFileToPath:(NSString *)path
{
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        NSString *sPath = [[NSBundle mainBundle] pathForResource:@"partysign" ofType:@"sqlite"];
        [manager copyItemAtPath:sPath toPath:path error:&error];
    }
    
    if (error) {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)copyDBFile
{
    return [XLDBTools copyDBFileToPath:[XLDBTools dbFilePath]];
}

@end
