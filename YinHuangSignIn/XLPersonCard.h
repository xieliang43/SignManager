//
//  XLPersonCard.h
//  YinHuangSignIn
//
//  Created by xie liang on 1/28/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLBaseView.h"
#import "XLPerson.h"

@protocol XLPersonCardDelegate;

@interface XLPersonCard : XLBaseView
{
    __weak UIImageView *_headView;
    __weak UIImageView *_signView;
    __weak UILabel *_nameLabel;
    __strong XLPerson *_person;
}

@property (nonatomic,weak) IBOutlet UIImageView *headView;
@property (nonatomic,weak) IBOutlet UIImageView *signView;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,assign) id<XLPersonCardDelegate> delegate;
@property (nonatomic,strong,setter = setPerson:) XLPerson *person;

- (IBAction)clickSelf:(id)sender;

@end

@protocol XLPersonCardDelegate <NSObject>

- (void)clickPersonCard:(XLPersonCard *)pCard;

@end
