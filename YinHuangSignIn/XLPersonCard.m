//
//  XLPersonCard.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/28/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLPersonCard.h"

@implementation XLPersonCard

@synthesize headView = _headView;
@synthesize signView = _signView;
@synthesize nameLabel = _nameLabel;
@synthesize person = _person;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setPerson:(XLPerson *)person
{
    _person = person;
    //设置头像
    NSString *picPath = [XLTools filePathWithName:person.picPath];
    if (picPath && [picPath length] > 0) {
        NSData *imageData = [NSData dataWithContentsOfFile:picPath];
        UIImage *image = [UIImage imageWithData:imageData];
        _headView.image = image;
    }
    
    //设置名称
    _nameLabel.text = _person.name;
    
    //设置标签
    if (_person.isSign) {
        _signView.image = [UIImage imageNamed:@"sign_sel.png"];
    }else{
        _signView.image = [UIImage imageNamed:@"sign_nor.png"];
    }
}

- (IBAction)clickSelf:(id)sender
{
    if ([_delegate respondsToSelector:@selector(clickPersonCard:)]) {
        [_delegate clickPersonCard:self];
    }
}

@end
