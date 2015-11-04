//
//  ViewControllerRoutes.m
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerRoutes.h"

@interface ViewControllerRoutes ()

@end

@implementation ViewControllerRoutes

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"Такси";
    
    dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;
    
    NSMutableArray * arrayDataBase = [[NSMutableArray alloc] init];
    
    arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from Routes"];
    
    [gallery setTabsBackgroundImage:nil WithSize:CGSizeMake(appWidth, 20)];
    [gallery setTabsImage:[UIImage imageNamed:@"galleryTab"] WithActiveTabImage:[UIImage imageNamed:@"galleryTabActive"]];

    for(NSMutableDictionary * element in arrayDataBase)
    {
        UIViewController * controller = [[ViewControllerRouteElement alloc] initWithNibName:@"ViewControllerRouteElement" bundle:nil arrayData:element];
        [gallery addController:controller];
    }
}

@end
