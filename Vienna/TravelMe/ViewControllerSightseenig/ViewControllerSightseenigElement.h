//
//  ViewControllerSightseenigElement.h
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBManager.h"
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import "MKStoreManager.h"

@protocol ViewControllerSightseenigElementDelegate <NSObject>
@optional
-(void)StartSightseeningDelegate:(NSMutableDictionary*)arrData;
@end

@interface ViewControllerSightseenigElement : UIViewController<MKStoreKitDelegate>
{
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelDescription;
    IBOutlet UIButton * buttonSightseenig;
    IBOutlet UIImageView * imageSightseenig;
    
    BOOL isBuying;
    NSMutableArray * arrayDataBase;
    DBManager * dataBase;
    
    NSString * name, * description;
    NSMutableArray * arrayAnnotation;
    CLLocationCoordinate2D location;
    
    int idSightseening;
    
    UIImage *saveImage;
}
@property  (nonatomic,strong)id<ViewControllerSightseenigElementDelegate> delegate;

-(void)prepareSightseening;
-(void) setButtonBuy;
-(void) setYesIsBuying;

-(IBAction)onStartSightseenig:(id)sender;

- (UIImage *)convertImageToGrayScale:(UIImage *)image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData;

@end
