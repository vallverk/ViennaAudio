//
//  ViewControllerRouteElement.m
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerRouteElement.h"

@interface ViewControllerRouteElement ()

@end

@implementation ViewControllerRouteElement

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *)arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrayAnnotation = [[NSMutableArray alloc] init];
        name = [arrayData objectForKey:@"name"];
        description = [arrayData objectForKey:@"description"];

        isBuying = [[arrayData objectForKey:@"isBuying"] isEqualToString:@"1"]?YES:NO;

        /*    dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;

         NSMutableArray* arrayDataIDSightseenings = (NSMutableArray*)[dataBase  loadDataFromDB:[NSString stringWithFormat:@"Select Sightseenings.id_sightseening from RouteSightseening,Sightseenings where RouteSightseening.id_routes == %@ and Sightseenings.id_sightseening  == RouteSightseening.id_sightseening",[arrayData objectForKey:@"id"]]];

         // используется дополнительная сортировка, так как order by RouteSightseening.number_sub в запросе сортирует только по первому символу и элементы дальше десятого оказываются в начале списка
         [arrayDataIDSightseenings sortUsingComparator: ^(id obj1, id obj2) {

         if ([[obj1 objectForKey:@"id_sightseening"] integerValue] > [[obj2 objectForKey:@"id_sightseening"] integerValue]) {
         return (NSComparisonResult)NSOrderedDescending;
         }

         if ([[obj1 objectForKey:@"id_sightseening"] integerValue] < [[obj2 objectForKey:@"id_sightseening"] integerValue]) {
         return (NSComparisonResult)NSOrderedAscending;
         }
         return (NSComparisonResult)NSOrderedSame;
         }];

         arrayDataBase = [[NSMutableArray alloc] init];
         for(int i = 0;i<[arrayDataIDSightseenings count];i++)
         {
         [arrayDataBase addObject:[dataBase loadDataFromDB:[NSString stringWithFormat:@"Select Element.*,Sightseenings.id_sightseening from Element,SightElements,Sightseenings where   SightElements.id_sightseening == %@ and Sightseenings.id_sightseening = SightElements.id_sightseening and Element.id == SightElements.id_element order by SightElements.number_sub",[[arrayDataIDSightseenings objectAtIndex:i] objectForKey:@"id_sightseening"]]]];
         }
         */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    points = [[NSMutableArray alloc] init];

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        [labelRoute setFont:[UIFont systemFontOfSize:16]];
        [labelName setFont:[UIFont systemFontOfSize:18]];
    }
    int idPin = 1;
    for(int i=0;i<[arrayDataBase count];i++)
    {
        NSMutableArray * dataSightseening = [arrayDataBase objectAtIndex:i];

        for(int j=0;j<[dataSightseening count];j++)
        {
            BOOL isBuyingSightseening = NO;

            if([[[[arrayDataBase objectAtIndex:i] objectAtIndex:j] objectForKey:@"isBuying"] intValue] == 11 && [MKStoreManager featureAPurchased])
                isBuyingSightseening = YES;
            if([[[[arrayDataBase objectAtIndex:i] objectAtIndex:j] objectForKey:@"isBuying"] intValue] == 12 && [MKStoreManager featureBPurchased])
                isBuyingSightseening = YES;
            else if ([[[[arrayDataBase objectAtIndex:i] objectAtIndex:j] objectForKey:@"isBuying"] intValue] != 11 || [[[[arrayDataBase objectAtIndex:i] objectAtIndex:j] objectForKey:@"isBuying"] intValue] != 12)
            {
                isBuyingSightseening = YES;
            }

            MapAnnotation *mp = [[MapAnnotation alloc] init];

            location.latitude=[[[dataSightseening objectAtIndex:j] objectForKey:@"latitude"] doubleValue];
            location.longitude=[[[dataSightseening objectAtIndex:j] objectForKey:@"longitude"] doubleValue];

            [mp setCoordinate:location];
            [mp setTitle:[[dataSightseening objectAtIndex:j] objectForKey:@"name"]];
            [mp setIsBuy:isBuyingSightseening?@"1":@"0"];
            if(isBuyingSightseening)
            {
                [mp setNameColorPin:@"pin"];
                [mp setNameColorBigPin:@"pin"];
            }
            else
            {
                [mp setNameColorPin:@"pin"];
                [mp setNameColorBigPin:@"pin"];
            }
            [mp setIdPin:[NSString stringWithFormat:@"%d",idPin]];

            CLLocation* currentLocation = [[CLLocation alloc] initWithLatitude:location.latitude
                                                                     longitude:location.longitude];
            [points addObject:currentLocation];

            NSMutableArray * dataAddAnnotation = (NSMutableArray*)[dataBase loadDataFromDB:[NSString stringWithFormat:@"Select latitude,longitude from AdditionalPoints where idElement == %@ order by number_sub",[[dataSightseening objectAtIndex:j] objectForKey:@"id"]]];

            for(int i=0;i<[dataAddAnnotation count];i++)
            {
                CLLocation* AddLocation = [[CLLocation alloc] initWithLatitude:[[[dataAddAnnotation objectAtIndex:i] objectForKey:@"latitude"] doubleValue]
                                                                     longitude:[[[dataAddAnnotation objectAtIndex:i] objectForKey:@"longitude"] doubleValue]];
                [points addObject:AddLocation];
            }

            [arrayAnnotation addObject:mp];

            idPin++;
        }
    }


    [labelName setText:name];
    [labelRoute setText:description];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)onStartRoute:(id)sender
{
    /*NSMutableDictionary *arrayData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:arrayAnnotation,@"arrayAnnotation",points,@"pointsAnnotation", arrayDataBase, @"arrayDataBase", nil];
     UIViewController * controller = [[ViewControllerViewRoute alloc] initWithNibName:@"ViewControllerViewRoute" bundle:nil arrayData:arrayData isSightseening:NO];
     [self.navigationController pushViewController:controller animated:YES];*/
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
        if(installed)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"skype:+436607555555?call"]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://austriaday.com"]];
        }
    }
    else
    {
        BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
        if(installed)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:+436607555555"]]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://austriaday.com"]];
        }
    }
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
