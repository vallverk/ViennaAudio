//
//  ViewControllerViewRoute.h
//  TravelMe
//
//  Created by Viktor Bondarev on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "MapAnnotation.h"
#import "UNRouteView.h"
#import "ViewControllerMapsPinIcon.h"
#import "ViewControllerViewSightseenig.h"
#import "RDVTabBarController.h"


@interface ViewControllerViewRoute :UIViewController<UINavigationControllerDelegate>
{
    IBOutlet UIButton * buttonBuy;
    IBOutlet UIView * viewSwitch;
    IBOutlet UIView * viewBuy;
    IBOutlet UIView * viewIconSelect;
    IBOutlet UISegmentedControl * segmentControl;

    NSMutableArray * viewPinView;
    ViewControllerMapsPinIcon * viewUserPin;
    NSMutableArray * dataString;

    ViewControllerViewSightseenig * controller;
    BOOL isSelectRoute;
    BOOL firstSelect;
    NSMutableArray * arrayAnnotation;
    NSMutableArray * points;
    NSMutableArray * arrayDataBase;
    int selectPin;
    MKAnnotationView * previousPin;
    
//    NSTimer *timerStartBuying;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData isSightseening:(BOOL) isSightseening;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) UNRouteView *routeView;

-(void) SelectPin:(id) text;

@end
