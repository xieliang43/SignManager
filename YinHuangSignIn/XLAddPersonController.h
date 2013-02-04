//
//  XLAddPersonController.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/28/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLBaseController.h"
#import "XLPersonCard.h"
#import "UIImageHelper.h"
#import "XLPerson.h"
#import "XLPersonService.h"

@interface XLAddPersonController : XLBaseController<XLPersonCardDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    XLPersonCard *personCard;
    __strong UIPopoverController *popCon;
    __strong XLPerson *_person;
}

@property(nonatomic,weak) IBOutlet UIView *contentView;
@property(nonatomic,weak) IBOutlet UITextField *nameField;
@property(nonatomic,weak) IBOutlet UITextField *acronymField;
@property(nonatomic,weak) IBOutlet UIButton *maleBtn;
@property(nonatomic,weak) IBOutlet UIButton *femaleBtn;

@property(nonatomic,strong) XLPerson *person;

- (IBAction)cancel:(id)sender;
- (IBAction)addPerson:(id)sender;
- (IBAction)clickMaleBtn:(id)sender;
- (IBAction)clickFemaleBtn:(id)sender;

@end
