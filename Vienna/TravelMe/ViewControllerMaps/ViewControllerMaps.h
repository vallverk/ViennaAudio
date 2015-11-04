//
//  ViewControllerMaps.h
//  TravelMe
//
//  Created by Андрей Катюшин on 04.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import <MapKit/Mapkit.h>
#import "MapAnnotation.h"
#import "ViewControllerMapsPinIcon.h"
#import "DBManager.h"
#import "AppDelegate.h"
#import "ViewControllerMapFilter.h"
#import "ViewControllerUniversalViewElementList.h"
#import "MKStoreManager.h"

@interface ViewControllerMaps : UIViewController<UINavigationControllerDelegate>
{
    IBOutlet MKMapView * mapView;
    CLLocationCoordinate2D location;
    
    NSMutableArray * viewPinView;
    ViewControllerMapsPinIcon * viewUserPin;
    NSMutableArray * dataString;
    NSMutableArray * arrayAnnotation;
    DBManager * dataBase;
    
    NSMutableArray * arrayDataBaseUniversal;
    NSMutableArray * arrayDataBaseSightseening;
    
    UIButton * buttonFilter;
    NSMutableArray * numberColorPin;
    
    NSMutableArray *arrayFilterData;
    
    int selectPin;
    double MinX,MinY,MaxX,MaxY;
    MKAnnotationView * previousPin;
    ViewControllerUniversalViewElementList *viewControllerUniversalViewElementList;
}

-(void)resizeRegion;
-(void)reloadAnnotationMap;
-(IBAction)onFilterClick:(id)sender;
-(int)retainIsBuy:(int)id_sightseening;
-(void)makeFilterForMap:(id) array;
-(void)filterForMap:(NSMutableArray *) arrayData;
-(void) filterAddAnnotationOrNot:(int) type isBuyingType:(int) typeBuying indexElement:(int) index idAnnotation:(int) idPin isFilterNoText:(BOOL) filterNoText arrayDataBase:(NSMutableArray *) arrayDataBase;

@end
