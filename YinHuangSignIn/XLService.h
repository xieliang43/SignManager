//
//  XLService.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLDBTools.h"
#import "FMDatabase.h"

@interface XLService : NSObject
{
    FMDatabase *fmdb;
}

@end
