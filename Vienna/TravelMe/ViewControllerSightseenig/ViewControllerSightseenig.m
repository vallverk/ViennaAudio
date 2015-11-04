//
//  ViewControllerSightseenig.m
//  TravelMe
//
//  Created by Viktor Bondarev on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerSightseenig.h"
#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>

@interface ViewControllerSightseenig ()

@end

@implementation ViewControllerSightseenig

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

    self.title = @"Экскурсии";

    [MKStoreManager sharedManager].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartBuying:) name:@"StartBuying" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartSightseening:) name:@"StartSightseening" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetActiveGalleryIndex:) name:@"SetActiveGalleryIndex" object:nil];

    [gallery setTabsImage:[UIImage imageNamed:@"galleryTab"] WithActiveTabImage:[UIImage imageNamed:@"galleryTabActive"]];
    
    dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;

    arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * from Sightseenings where is_visible == 1"];
    
    for(NSMutableDictionary * element in arrayDataBase)
    {
        ViewControllerSightseenigElement * controller = [[ViewControllerSightseenigElement alloc] initWithNibName:@"ViewControllerSightseenigElement" bundle:nil arrayData:element];
        controller.delegate = self;
        [gallery addControllerWihtoutOffset:(UIViewController*)controller];
    }
}

-(void)SetActiveGalleryIndex:(id) text
{
    //    int id_sightseeing = [((NSString *) [text object]) intValue];
    int id_sightseeing = 0;
    for(NSMutableDictionary * element in arrayDataBase)
    {
        if([[element objectForKey:@"id_sightseening"] isEqualToString:(NSString *) [text object]])
        {
            break;
        }
        id_sightseeing++;
    }


    [gallery setActiveControllerAtIndex:id_sightseeing];
}

- (void)StartSightseening:(id) text
{
    int id_sightseening = [(NSString *) [text object] intValue];

       [Answers logCustomEventWithName:@"Choose an excursion"
                    customAttributes:@{
                                     @"index" : [NSString stringWithFormat:@"%d",id_sightseening]
                                 }];
    
    ViewControllerSightseenigElement * controller = (ViewControllerSightseenigElement*)[gallery getController:id_sightseening-1];
    [controller prepareSightseening];
}

-(void)StartSightseeningDelegate:(NSMutableDictionary*)arrayData
{
    ViewControllerViewRoute*controller = [[ViewControllerViewRoute alloc] initWithNibName:@"ViewControllerViewRoute" bundle:nil arrayData:arrayData isSightseening:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)StartBuying:(id) text
{
   // [((AppDelegate *)[[UIApplication sharedApplication] delegate]).lockScreen startLock];
    int id_sightseening = [(NSString *) [text object] intValue];
    if(id_sightseening == 11)[[MKStoreManager sharedManager] buyFeatureA];
    if(id_sightseening == 12)[[MKStoreManager sharedManager] buyFeatureB];
}

- (void)productAPurchased
{
 //   [((AppDelegate *)[[UIApplication sharedApplication] delegate]).lockScreen stopLock];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadAnnotationMap" object:nil];
    ViewControllerSightseenigElement * controller = (ViewControllerSightseenigElement*)[gallery getController:10];
    [controller setYesIsBuying];
    [controller setButtonBuy];
    [controller prepareSightseening];
}

- (void)productBPurchased
{
   // [((AppDelegate *)[[UIApplication sharedApplication] delegate]).lockScreen stopLock];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadAnnotationMap" object:nil];
    ViewControllerSightseenigElement * controller = (ViewControllerSightseenigElement*)[gallery getController:11];
    [controller setYesIsBuying];
    [controller setButtonBuy];
    [controller prepareSightseening];
}

// покупка не прошла, либо была отменена
- (void)failed
{
  //  [((AppDelegate *)[[UIApplication sharedApplication] delegate]).lockScreen stopLock];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetBuyingNO" object:nil];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
