//
//  ViewControllerUserfulInformation.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerUserfulInformation.h"
#import "ViewControllerUserfulInformationCell.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"


@interface ViewControllerUserfulInformation ()

@end

@implementation ViewControllerUserfulInformation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        elements = [[NSMutableArray alloc] init];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Музеи", @"name", 
                             @"museum_icon", @"imageName",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Рестораны", @"name",
                             @"restaurant_icon", @"imageName",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Магазины", @"name",
                             @"Shop_icon", @"imageName",nil]];
//        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                             @"Аэропорты", @"name",
//                             @"imageIconAirport", @"imageName",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Бары и клубы", @"name",
                             @"bars_icon", @"imageName",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Полезные телефоны", @"name",
                             @"phones_icon", @"imageName",nil]];
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerUserfulInformationCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerUserfulInformationCell" forIndexPath:indexPath];
    [cell setData:[elements objectAtIndex:indexPath.row]];
    [cell updateData];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [cell setPreservesSuperviewLayoutMargins:NO];

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:0];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:
        {
            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:1];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:
        {
            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:2];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
//        case 3:
//        {
//            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:4];
//            [controller setNavigationController:navigationController];
//            [navigationController pushUIViewController:controller WithName:@"Аэропорты и вокзалы"];
//        }
            break;
        case 3:
        {
            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:5];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:
        {
            ViewControllerUsefulPhonesList * controller = [[ViewControllerUsefulPhonesList alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Полезная информация";

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    [tableController registerNib:[UINib nibWithNibName:NSStringFromClass([ViewControllerUserfulInformationCell class]) bundle:nil] forCellReuseIdentifier:@"ViewControllerUserfulInformationCell"];

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
