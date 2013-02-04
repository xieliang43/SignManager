//
//  XLPersonController.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLBaseController.h"
#import "XLPersonService.h"
#import "XLAddPersonController.h"
#import "XLPersonCell.h"
#import "XLPersonCard.h"

@interface XLPersonController : XLBaseController<UITableViewDelegate,UITableViewDataSource,XLPersonCardDelegate,UITextFieldDelegate>
{
    __strong NSString *keyWord;
    __strong NSString *isSign;
    NSInteger selectPersonId;
}

@property(nonatomic,strong) XLPersonService *service;
@property(nonatomic,strong) NSMutableArray *indexArray;
@property(nonatomic,strong) NSMutableDictionary *personDic;
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,copy) NSString *personType;

@property(nonatomic,weak) IBOutlet UITextField *searchField;

- (IBAction)goBack:(id)sender;
- (IBAction)clickAddBtn:(id)sender;
- (IBAction)clickConditionBtn:(UIButton *)sender;

@end
