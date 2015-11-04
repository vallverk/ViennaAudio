//
//  ViewControllerUniversalViewElementList.h
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import <QuartzCore/QuartzCore.h>
#import "FXImageView.h"
@interface ViewControllerUniversalViewElementList :  UIViewController
{
    IBOutlet MKMapView * mapView;
    IBOutlet UILabel * labelName;
    IBOutlet UITextView * labelDescription;
    IBOutlet UITextView * labelWorkDays;
    IBOutlet UITextView * labelFreeDays;
    IBOutlet UIButton * labelContacts;
    IBOutlet UIView * viewIconSelect;
    IBOutlet UIView * viewMain;
    IBOutlet UIScrollView * scroll;
    IBOutlet FXImageView * photo;
    IBOutlet UIButton * labelSite;
    IBOutlet UIImageView * logo;

    
    IBOutlet UILabel * labelOperationMode;
    IBOutlet UILabel * labelContactsInforamtion;
    IBOutlet UILabel * labelSiteInformation;
    
    CLLocationCoordinate2D location;
    NSString *name,*description,*workdays,*freedays,*contacts,*adress,*name_photo, *site;
    NSInteger type;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
-(void)setData:(NSMutableDictionary*)arrayData;
-(IBAction)onCallPhone:(id)sender;
-(IBAction)onCallSite:(id)sender;

@end
