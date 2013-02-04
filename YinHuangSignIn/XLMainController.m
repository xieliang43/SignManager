//
//  XLMainController.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLMainController.h"

@interface XLMainController ()

@end

@implementation XLMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"主界面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


- (IBAction)maleRelative:(id)sender
{
    NSLog(@"男方亲友");
    XLPersonController *personCon = [[XLPersonController alloc] initWithNibName:nil bundle:nil];
    personCon.personType = @"male";
    [self.navigationController pushViewController:personCon animated:YES];
}

- (IBAction)femaleRelative:(id)sender
{
    NSLog(@"女方亲友");
    XLPersonController *personCon = [[XLPersonController alloc] initWithNibName:nil bundle:nil];
    personCon.personType = @"female";
    [self.navigationController pushViewController:personCon animated:YES];
}

@end
