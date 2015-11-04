//
//  ViewControllerMore.m
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerMore.h"
#import "ViewControllerMoreCell.h"

@interface ViewControllerMore ()

@end

@implementation ViewControllerMore

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        elements = [[NSMutableArray alloc] init];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Полезная информация", @"name", 
                             @"info_icon", @"imageName",nil]];
        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Карты", @"name",
                             @"maps_icon", @"imageName",nil]];
//        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                             @"Другие программы", @"name",
//                             @"imageIconOtherProgram", @"imageName",nil]];
//        [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                             @"О нас", @"name",
//                             @"imageIconMoreAboutUs", @"imageName",nil]];
    
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
    ViewControllerMoreCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerMoreCell" forIndexPath:indexPath];
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
            ViewControllerUserfulInformation * controller = [[ViewControllerUserfulInformation alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:
        {
            ViewControllerMaps * controller = [[ViewControllerMaps alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
         }
            break;
//        case 2:
//        {
//            ViewControllerUniversalList * controller = [[ViewControllerUniversalList alloc] initWithNibName:@"ViewControllerUniversalList" bundle:nil type:3];
//            [controller setNavigationController:navigationController];
//            [navigationController pushUIViewController:controller WithName:@"Другие программы"];
//        }
//            break;
//        case 3:
//        {
//            ViewControllerAboutUs * controller = [[ViewControllerAboutUs alloc] init];
//            [controller setNavigationController:navigationController];
//            [navigationController pushUIViewController:controller WithName:@"О нас"];
//        } 
//            break; 

        default:
            break;
    }
}
////////////////////


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Еще";

    [tableController registerNib:[UINib nibWithNibName:NSStringFromClass([ViewControllerMoreCell class]) bundle:nil] forCellReuseIdentifier:@"ViewControllerMoreCell"];

    [tableController reloadData];

    tableController.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view from its nib.
}

@end
