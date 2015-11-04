//
//  ViewControllerUniversalList.m
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerUniversalList.h"
#import "ViewControllerUniversalListCell.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@interface ViewControllerUniversalList ()

@end

@implementation ViewControllerUniversalList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(NSInteger) type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        typeElement = type;
        
        typeNumber = [NSString stringWithFormat:@"%ld",(long)typeElement];
        
        elements = [[NSMutableArray alloc] init];
        
        dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;
        
        NSMutableArray * arrayDataBase = [[NSMutableArray alloc] init];
        
        switch (type) {
            case 0:
            {
                typeName = @"Музеи";
                
                arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from UniversalList where type = 0"];
                
                
            }
                break;
                
            case 1:
                typeName = @"Рестораны";
                arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from UniversalList where type = 1"];
               
                break;
            case 2:
                typeName = @"Магазины";
                arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from UniversalList where type = 2"];
            
               
                break;
            case 3:
                typeName = @"Программы";
                arrayDataBase =(NSMutableArray*) [dataBase loadDataFromDB:@"Select * from UniversalList where type = 3"];
//                [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                     @"Барселона", @"name", 
//                                     @"imageIconTemp", @"imageName",
//                                     @"Краткое описание приложения",@"descriptionShort",nil]];
//                [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                     @"Веселый кавказ", @"name", 
//                                     @"imageIconTemp", @"imageName",
//                                     @"Краткое описание приложения",@"descriptionShort",nil]];
//                [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                     @"Москва", @"name", 
//                                     @"imageIconTemp", @"imageName",
//                                     @"Краткое описание приложения",@"descriptionShort",nil]];
                break;
            case 4:
                typeName = @"Аэропорты и вокзалы";
                arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from UniversalList where type = 4"];
               
                
                break;
            case 5:
            {
                typeName = @"Бары и клубы";
                arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from UniversalList where type = 5"];
            }
                break;
            default:
                break;
        }
        
//        if(type != 3)
//        {
        for(int i=0;i<[arrayDataBase count];i++)
        {
            [elements addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"name"], @"name",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"descriptionShort"],@"descriptionShort",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"description"],@"description",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"workdays"],@"workdays",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"freedays"],@"freedays",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"contacts"],@"contacts",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"latitude"],@"latitude",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"longitude"],@"longitude",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"adress"], @"adress",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"name_photo"], @"name_photo",
                                 [[arrayDataBase objectAtIndex:i] objectForKey:@"site"], @"site",
                                 typeNumber, @"type", nil]];
        }
//        }
        
        // Custom initialization
        self.title = typeName;
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
    ViewControllerUniversalListCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerUniversalListCell" forIndexPath:indexPath];
    [cell setData:[elements objectAtIndex:indexPath.row]];
    [cell updateData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(typeElement != 3)
    {
        NSMutableDictionary * arrayData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[elements objectAtIndex:indexPath.row] objectForKey:@"name"],@"name",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"description"],@"description",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"workdays"],@"workdays",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"freedays"],@"freedays",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"contacts"],@"contacts",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"latitude"],@"latitude",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"longitude"],@"longitude",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"adress"],@"adress",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"name_photo"], @"name_photo",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"descriptionShort"], @"descriptionShort",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"site"], @"site",
                                           typeNumber,@"type",
                                           nil];
    
        [viewControllerUniversalViewElementList setData:arrayData];
        
        [self.navigationController pushViewController:viewControllerUniversalViewElementList animated:YES];
    }
    else {
        NSMutableDictionary * arrayData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[elements objectAtIndex:indexPath.row] objectForKey:@"description"],@"description",
                                           [[elements objectAtIndex:indexPath.row] objectForKey:@"descriptionShort"], @"descriptionShort",
                                           nil];
        
        ViewControllerOtherPrograms * controller = [[ViewControllerOtherPrograms alloc] initWithNibName:@"ViewControllerOtherPrograms" bundle:nil arrayData:arrayData];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    [tableController registerNib:[UINib nibWithNibName:NSStringFromClass([ViewControllerUniversalListCell class]) bundle:nil] forCellReuseIdentifier:@"ViewControllerUniversalListCell"];

    viewControllerUniversalViewElementList = [[ViewControllerUniversalViewElementList alloc] initWithNibName:@"ViewControllerUniversalViewElementList" bundle:nil];

    tableController.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [tableController setShowsVerticalScrollIndicator:NO];
}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) dealloc
{
    [elements removeAllObjects];
    elements = nil;
    typeName = nil;
}

@end
