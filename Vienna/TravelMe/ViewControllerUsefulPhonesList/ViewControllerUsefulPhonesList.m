//
//  ViewControllerUsefulPhonesList.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerUsefulPhonesList.h"
#import "ViewControllerUsefulPhonesListCell.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@interface ViewControllerUsefulPhonesList ()

@end

@implementation ViewControllerUsefulPhonesList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        elements = [[NSMutableArray alloc] init];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Заказ Экскурсий и Трансфера в Австрии", @"name",
                             @"+436607555555,Заказ Экскурсий и Трансфера",@"description",
                             @"+436607555555",@"phone",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Информация по Австрии на русском языке", @"name",
                             @"+436607555555,Информация на русском",@"description",
                             @"+436607555555",@"phone",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Полиция", @"name",
                             @"133, Полиция",@"description",
                             @"133",@"phone",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Скорая помощь", @"name",
                             @"144, Скорая помощь",@"description",
                             @"144",@"phone",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Пожарная", @"name",
                             @"122, Пожарная",@"description",
                             @"122",@"phone",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Общая помощь", @"name",
                             @"112, Общая помощь",@"description",
                             @"112",@"phone",nil]];
        
        // Custom initialization
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return elements.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 52.0;}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerUsefulPhonesListCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerUsefulPhonesListCell" forIndexPath:indexPath];
    [cell setData:[elements objectAtIndex:indexPath.row]];
    [cell updateData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Полезные телефоны";

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    [tableController registerNib:[UINib nibWithNibName:NSStringFromClass([ViewControllerUsefulPhonesListCell class]) bundle:nil] forCellReuseIdentifier:@"ViewControllerUsefulPhonesListCell"];

    [tableController reloadData];
    // Do any additional setup after loading the view from its nib.
    tableController.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) dealloc
{
    [elements removeAllObjects];
    elements = nil;
}

@end
