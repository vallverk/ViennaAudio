//
//  ViewControllerRouteElement.h
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UNRouteView.h"
#import "MapAnnotation.h"
#import "ViewControllerViewRoute.h"
#import "DBManager.h"
#import "AppDelegate.h"
#import "MKStoreManager.h"

@interface ViewControllerRouteElement : UIViewController
{
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelRoute;
    IBOutlet UIView * viewIconSelect;
    
    NSMutableArray * dataString;
    CLLocationCoordinate2D location;
    NSMutableArray* points;
    NSMutableArray* arrayAnnotation;
    NSMutableArray* arrayDataBase;
    NSString * name,*description,*idElement;
    BOOL isBuying;
    DBManager * dataBase;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *)arrayData;

-(IBAction)onStartRoute:(id)sender;

@end
