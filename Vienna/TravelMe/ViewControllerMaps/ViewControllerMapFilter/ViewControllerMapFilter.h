//
//  ViewControllerMapFilter.h
//  TravelMe
//
//  Created by Viktor Bondarev on 14.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UICustomSwitch.h"

@interface ViewControllerMapFilter : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITextField * fieldSearch;
    IBOutlet UILabel * labelPlaceHolder;
    IBOutlet UICustomSwitch * switchShop;
    IBOutlet UICustomSwitch * switchMuseum;
    IBOutlet UICustomSwitch * switchRestoraunt;
    IBOutlet UICustomSwitch * switchSightseening;
    IBOutlet UICustomSwitch * switchSightseeningNotBuy;
    
    IBOutlet UIButton *barsFilterButton;
    IBOutlet UIButton *restrauntFilterButton;
    IBOutlet UIButton *museumsFilterButton;
    IBOutlet UIButton *shopFilterButton;
    IBOutlet UIButton *excursionsFilterButton;
    
    BOOL barsFilterFlag;
    BOOL restrauntFilterFlag;
    BOOL museumsFilterFlag;
    BOOL shopFilterFlag;
    BOOL excursionsFilterFlag;
    
    NSMutableArray *arrayFilterData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableArray *) arrayData;
- (IBAction)onShopsTracking:(id)sender;
- (IBAction)onMuseumsTracking:(id)sender;
- (IBAction)onRestrauntsTracking:(id)sender;
- (IBAction)onExcursionsTracking:(id)sender;
- (IBAction)onBarsTracking:(id)sender;

@end
