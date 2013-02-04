//
//  XLAddPersonController.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/28/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLAddPersonController.h"

@interface XLAddPersonController ()

@end

@implementation XLAddPersonController

@synthesize person = _person;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidHide)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
        
        _person = [[XLPerson alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    personCard = [[[NSBundle mainBundle] loadNibNamed:@"XLPersonCard"
                                                owner:self
                                              options:nil] lastObject];
    
    CGRect rect = personCard.frame;
    rect.origin.x = 179;
    rect.origin.y = 112;
    personCard.frame = rect;
    personCard.delegate = self;
    personCard.nameLabel.textAlignment = UITextAlignmentCenter;
    personCard.signView.hidden = YES;
    personCard.nameLabel.text = @"上传照片";
    
    [self.contentView addSubview:personCard];
    
    if ([self.person.type isEqualToString:@"male"]) {
        self.maleBtn.selected = YES;
    }else{
        self.femaleBtn.selected = YES;
    }
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

- (IBAction)clickMaleBtn:(id)sender
{
    self.maleBtn.selected = YES;
    self.femaleBtn.selected = NO;
    _person.type = @"male";
}

- (IBAction)clickFemaleBtn:(id)sender
{
    self.maleBtn.selected = NO;
    self.femaleBtn.selected = YES;
    _person.type = @"female";
}

- (IBAction)addPerson:(id)sender
{
    
    if (!(self.nameField.text && [self.nameField.text length] > 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"名称不能为空！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (!(self.acronymField.text && [self.acronymField.text length] > 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"名称拼音缩写不能为空！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(personCard.headView.image, 0.8);
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *name = [NSString stringWithFormat:@"%.0f.jpg",time];
    NSString *picPath = [XLTools filePathWithName:name];
    [imageData writeToFile:picPath atomically:YES];
    _person.picPath = name;
    
    _person.acronym = self.acronymField.text;
    _person.prefix = [_person.acronym substringToIndex:1];
    _person.name = self.nameField.text;
    
    XLPersonService *service = [[XLPersonService alloc] init];
    BOOL result = [service addPerson:_person];
    NSNumber *number = [NSNumber numberWithBool:result];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_FINISH_ADD_PERSON"
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObject:number forKey:@"result"]];
    [self cancel:nil];
}

- (IBAction)cancel:(id)sender
{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)keyboardDidShow
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.contentView.frame;
    rect.origin.y = -160;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}

- (void)keyboardDidHide
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.contentView.frame;
    rect.origin.y = 0;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - XLPersonCardDelegate
- (void)clickPersonCard:(XLPersonCard *)pCard
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        if (!popCon) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            popCon = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            popCon.popoverContentSize = CGSizeMake(182, 263);
        }
        
        [popCon presentPopoverFromRect:pCard.frame
                                inView:self.view
              permittedArrowDirections:UIPopoverArrowDirectionLeft
                              animated:YES];
    }
}

#pragma mark
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [popCon dismissPopoverAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [image scaleToSize:CGSizeMake(182, 263)];
    personCard.headView.image = image;
}

@end
