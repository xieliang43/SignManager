//
//  XLDBTools.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLTools.h"

@interface XLDBTools : NSObject

+ (NSString *)dbFilePath;
+ (BOOL)copyDBFileToPath:(NSString *)path;
+ (BOOL)copyDBFile;

@end
