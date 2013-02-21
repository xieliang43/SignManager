//
//  XLPersonController.m
//  YinHuangSignIn
//
//  Created by xie liang on 1/23/13.
//  Copyright (c) 2013 xieliang. All rights reserved.
//

#import "XLPersonController.h"

@interface XLPersonController ()

@end

@implementation XLPersonController

@synthesize tableView = _tableView;
@synthesize personType = _personType;
@synthesize indexArray = _indexArray;
@synthesize personDic = _personDic;
@synthesize service = _service;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DID_FINISH_ADD_PERSON" object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.indexArray = [NSMutableArray array];
        self.personDic = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(addPersonFinish:)
                                                     name:@"DID_FINISH_ADD_PERSON"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        self.tableView.sectionIndexColor = [UIColor whiteColor];
    }
    self.service = [[XLPersonService alloc] init];
    isSign = nil;
    keyWord = nil;
    [self fetchPersons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPersonFinish:(NSNotification *)noti
{
    NSNumber *numb = [noti.userInfo objectForKey:@"result"];
    BOOL result = [numb boolValue];
    if (result) {
        [self fetchPersons];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"添加贵宾成功！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)clickAddBtn:(id)sender
{
    XLAddPersonController *addPerson = [[XLAddPersonController alloc] initWithNibName:nil bundle:nil];
    addPerson.modalPresentationStyle = UIModalPresentationFormSheet;
    addPerson.person.type = self.personType;
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:addPerson animated:YES completion:nil];
    }else{
        [self presentModalViewController:addPerson animated:YES];
    }
    
}

- (void)fetchPersons
{
    
    [self.indexArray removeAllObjects];
    [self.personDic removeAllObjects];
    
    if (self.searchField.text && [self.searchField.text length] > 0) {
        keyWord = self.searchField.text;
    }else{
        keyWord = nil;
    }
    
    NSArray *array = [self.service getPersonsByKeyWord:keyWord withType:self.personType isSign:isSign];
    for (XLPerson *p in array) {
        if ([self.indexArray containsObject:p.prefix]) {
            [[self.personDic objectForKey:p.prefix] addObject:p];
        }else{
            [self.indexArray addObject:p.prefix];
            NSMutableArray *persons = [NSMutableArray array];
            [persons addObject:p];
            [self.personDic setObject:persons forKey:p.prefix];
        }
    }
    
    [self.tableView reloadData];
}

- (IBAction)clickConditionBtn:(UIButton *)sender
{
    [self.searchField resignFirstResponder];
    
    if (sender.tag == 1001) {
        isSign = nil;   //不限
    }else if (sender.tag == 1002){
        isSign = @"1";  //已签到
    }else if (sender.tag == 1003){
        isSign = @"0";  //未签到
    }
    
    [self fetchPersons];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchField resignFirstResponder];
    [self fetchPersons];
    return YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
//datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.indexArray objectAtIndex:section];
    return (NSInteger)ceil([[self.personDic objectForKey:key] count]/4.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLPersonCell *cell = nil;
    static NSString *cellId = @"PERSON_CELL";
    
    cell = (XLPersonCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XLPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    for (UIView *v in [cell subviews]) {
        [v removeFromSuperview];
    }
    
    NSString *key = [self.indexArray objectAtIndex:indexPath.section];
    NSArray *persons = [self.personDic objectForKey:key];
    for (int i = 0; i < 4; i++) {
        int index = indexPath.row * 4 + i;
        if (index >= [persons count]) {
            break;
        }
        XLPerson *person = [persons objectAtIndex:index];
        XLPersonCard *personCard = [[[NSBundle mainBundle] loadNibNamed:@"XLPersonCard" owner:self options:nil] lastObject];
        personCard.person = person;
        personCard.delegate = self;
        
        CGRect rect = personCard.frame;
        rect.origin.y = 0;
        rect.origin.x = 59 + (182 + 59) * i;
        personCard.frame = rect;
        
        [cell addSubview:personCard];
    }
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

#pragma mark - XLPersonCardDelegate
- (void)clickPersonCard:(XLPersonCard *)pCard
{
    if (!pCard.person.isSign) {
        selectPersonId = pCard.person.uid;
        NSString *content = [NSString stringWithFormat:@"当前选择贵宾-%@，是否确定签到？",pCard.person.name];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:content
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:@"取消",nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.service personSignInWithId:selectPersonId];
        [self fetchPersons];
    }
}

@end
