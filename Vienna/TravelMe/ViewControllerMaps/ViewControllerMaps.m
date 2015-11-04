//
//  ViewControllerMaps.m
//  TravelMe
//
//  Created by Андрей Катюшин on 04.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerMaps.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@interface ViewControllerMaps ()

@end

@implementation ViewControllerMaps

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        viewUserPin = [[ViewControllerMapsPinIcon alloc] init];
        arrayAnnotation = [[NSMutableArray alloc] init];
        viewPinView = [[NSMutableArray alloc] init];
        numberColorPin = [[NSMutableArray alloc] init];
        
        selectPin = 0;
        
        dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;
        
        arrayDataBaseUniversal = (NSMutableArray*)[dataBase loadDataFromDB:@"Select * From UniversalList where type!=3"];
        
        arrayDataBaseSightseening = (NSMutableArray*)[dataBase loadDataFromDB:@"Select Element.latitude,Element.longitude,Element.name,Sightseenings.id_sightseening from Element,Sightseenings,SightElements where Element.id == SightElements.id_element and Sightseenings.id_sightseening == SightElements.id_sightseening and Sightseenings.is_visible == 1"];
        
        buttonFilter = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [buttonFilter setBackgroundImage:[UIImage imageNamed:@"navigationControllerFilterButton"] forState:UIControlStateNormal];
        [buttonFilter addTarget:self action:@selector(onFilterClick:) forControlEvents:UIControlEventTouchDown];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeFilterForMap:) name:@"makeFilterForMap" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAnnotationMap) name:@"reloadAnnotationMap" object:nil];
    
    mapView.showsUserLocation = YES;
    
    arrayFilterData = [[NSMutableArray alloc] init];
    for(int i=0;i<6;i++)
        [arrayFilterData addObject:@"1"];
    [arrayFilterData addObject:@""];
    
    [self filterForMap:arrayFilterData];
    
    if([arrayAnnotation count]>0)
    {
        
        MinX=MaxX=((MapAnnotation *)[arrayAnnotation objectAtIndex:0]).coordinate.latitude;
        MinY=MaxY=((MapAnnotation *)[arrayAnnotation objectAtIndex:0]).coordinate.longitude;
        for(int i=0;i<[arrayAnnotation count];i++)
        {
            
            location = ((MapAnnotation *)[arrayAnnotation objectAtIndex:i]).coordinate;
            if(MinX>location.latitude)
            {
                MinX = location.latitude;
            }
            if(MaxX<location.latitude)
            {
                MaxX = location.latitude;
            }
            if(MinY>location.longitude)
            {
                MinY = location.longitude;
            }
            if(MaxY<location.longitude)
            {
                MaxY = location.longitude;
            }
        }
        
        MKCoordinateRegion region = {{(MaxX-MinX)/2+MinX, (MaxY-MinY)/2+MinY}, {0.0f, 0.0f}}; 
        //region.center = locationfromfavorites;
        region.span.longitudeDelta = (MaxY-MinY); region.span.latitudeDelta = (MaxX-MinX);
        [mapView setRegion:region animated:NO];
    }

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    UIBarButtonItem*btnSearch = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"navigationControllerFilterButton" withButtonPressedImage:nil target:self action:@selector(onFilterClick:)];

    self.navigationItem.rightBarButtonItem = btnSearch;

    self.title = @"Карты";

    viewControllerUniversalViewElementList= [[ViewControllerUniversalViewElementList alloc] initWithNibName:@"ViewControllerUniversalViewElementList" bundle:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = nil;
    
    if (annotation != mapView.userLocation)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Площадь Ленина,д.7"];
        if (annotationView) {
            annotationView.canShowCallout=NO;
            [annotationView setImage:[UIImage imageNamed:[((MapAnnotation *) annotationView.annotation) nameColorPin]]];

            [annotationView setCenterOffset:CGPointMake(0, -annotationView.frame.size.height/2+3)];
            
            int index = [[((MapAnnotation *) annotationView.annotation) idPin] integerValue]-1;
            
            [((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view setFrame:CGRectMake(0,0,147,42)];
            [((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view setHidden:YES];
            [annotationView addSubview:((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view];
            
            [((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view setFrame:CGRectMake(((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.origin.x-(((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.size.width-annotationView.frame.size.width)/2-3, ((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.origin.y-((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.size.height, 
                                                                                                       ((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.size.width, 
                                                                                                       ((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view.frame.size.height)];
            
            
            NSArray * viewsIconSelectPin = [((ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:index]).view subviews];
            [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setText:[annotationView.annotation title]];
            [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

            return annotationView;
        }
    }
    else 
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Площадь Ленина,д.7"];
        if (annotationView) {
            annotationView.canShowCallout=NO;
            [annotationView setImage:[UIImage imageNamed:@"userPin"]];
            
            [annotationView setCenterOffset:CGPointMake(0, -annotationView.frame.size.height/2+3)];
                        
            [viewUserPin.view setFrame:CGRectMake(0,0,147,42)];
            [viewUserPin.view  setHidden:YES];
            [annotationView addSubview:viewUserPin.view];
            
            [viewUserPin.view setFrame:CGRectMake(viewUserPin.view.frame.origin.x-(viewUserPin.view.frame.size.width-annotationView.frame.size.width)/2-3, viewUserPin.view.frame.origin.y-viewUserPin.view.frame.size.height, 
                                                                                                       viewUserPin.view.frame.size.width, 
                                                                                                       viewUserPin.view.frame.size.height)];
            
            
            NSArray * viewsIconSelectPin = [viewUserPin.view subviews];
            [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setText:@"Текущая позиция"];
            [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

            return annotationView;
        }

    }
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapV didAddAnnotationViews:(NSArray *)views
{
    if((( MKAnnotationView *) [views objectAtIndex:0]).annotation != mapView.userLocation)
    {

    }
    else {
        MKAnnotationView *aV;
        for (aV in views) {
            if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
                MKAnnotationView* annotationView = aV;
                annotationView.canShowCallout = NO;
                
            }
        }
    }
}

- (void)mapView:(MKMapView *)map didSelectAnnotationView:(MKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:NO];
        
    [mapView setCenterCoordinate:((MapAnnotation *) view.annotation).coordinate animated:NO];
    
    if(previousPin.annotation != mapView.userLocation)
    {
        ViewControllerMapsPinIcon * iconPinPrevios = (ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:selectPin];        
        
        [previousPin setFrame:CGRectMake(previousPin.frame.origin.x, previousPin.frame.origin.y+4,previousPin.frame.size.width,previousPin.frame.size.height)];
        [previousPin setImage:[UIImage imageNamed:[((MapAnnotation *) previousPin.annotation) nameColorPin]]];
        
        [iconPinPrevios.view setFrame:CGRectMake(0, 0, 147, 42)];
        [iconPinPrevios.view setHidden:YES];
    }
    else
    {
        [viewUserPin.view setHidden:YES];
    }
    
    if (view.annotation != mapView.userLocation)
    {
        selectPin = [[((MapAnnotation *)view.annotation) idPin] integerValue]-1;
        
        [view setImage:[UIImage imageNamed:[((MapAnnotation *) view.annotation) nameColorBigPin]]];
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-4,view.frame.size.width,view.frame.size.height)];
        
        ViewControllerMapsPinIcon * iconPin = (ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:([((MapAnnotation *) view.annotation).idPin integerValue]-1)];
        [iconPin.view setHidden:NO];
        [iconPin.view setFrame:CGRectMake(0, 0, 147, 42)];
        [iconPin.view setFrame:CGRectMake(iconPin.view.frame.origin.x - (iconPin.view.frame.size.width-view.frame.size.width)/2-3, iconPin.view.frame.origin.y-iconPin.view.frame.size.height,iconPin.view.frame.size.width, iconPin.view.frame.size.height)];

        NSArray * viewsIconSelectPin = [iconPin.view subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

        int index = [((MapAnnotation *) view.annotation).idPin integerValue];
        
        if(index > [arrayDataBaseUniversal count] && previousPin.annotation == view.annotation)
        {
            [((AppDelegate *)[[UIApplication sharedApplication] delegate]) onClickSightseeng:[[arrayDataBaseSightseening objectAtIndex:(index-[arrayDataBaseUniversal count]-1)] objectForKey:@"id_sightseening"]];
        }
        else if(previousPin.annotation == view.annotation)
        {
            index -=1;
            NSMutableDictionary * arrayData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"name"],@"name",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"description"],@"description",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"workdays"],@"workdays",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"freedays"],@"freedays",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"contacts"],@"contacts",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"latitude"],@"latitude",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"longitude"],@"longitude",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"adress"],@"adress",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"name_photo"], @"name_photo",
                                               [[arrayDataBaseUniversal objectAtIndex:index] objectForKey:@"type"],@"type",
                                               nil];
            
          [viewControllerUniversalViewElementList  setData:arrayData];
            [self.navigationController pushViewController:viewControllerUniversalViewElementList animated:YES];
        }
    }
    else
    {
        [viewUserPin.view  setHidden:NO];
        NSArray * viewsIconSelectPin = [viewUserPin.view subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];
    }
    
    previousPin = view;
}


/*-(void)SoGeNavigationController:(SoGeNavigationController *)navigationControllerElement changeElementTo:(UIViewController *)newController
{
    if(newController == self)
    {
        [navigationController pushRightButton:buttonFilter];
    }
}*/

-(IBAction)onFilterClick:(id)sender
{
    ViewControllerMapFilter * controller = [[ViewControllerMapFilter alloc] initWithNibName:@"ViewControllerMapFilter" bundle:nil arrayData:arrayFilterData];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)resizeRegion
{
    if(MinX != 1000)
    {
        MKCoordinateRegion region = {{(MaxX-MinX)/2+MinX, (MaxY-MinY)/2+MinY}, {0.0f, 0.0f}};
        if(![[arrayFilterData objectAtIndex:([arrayFilterData count]-1)] isEqualToString:@""])
        {
            region.span.longitudeDelta = (MaxY-MinY+0.02); region.span.latitudeDelta = (MaxX-MinX+0.02);
            
        }
        else {
            region.span.longitudeDelta = (MaxY-MinY); region.span.latitudeDelta = (MaxX-MinX);
        }
        [mapView setRegion:region animated:NO];
    }
}

-(void)reloadAnnotationMap
{
    [self filterForMap:arrayFilterData];
    [self resizeRegion];
}

-(void)makeFilterForMap:(id) array
{
    NSMutableArray *arrayData = (NSMutableArray*)[array object];
    [self filterForMap:arrayData];
    [self resizeRegion];
}

-(void) filterAddAnnotationOrNot:(int) type isBuyingType:(int) typeBuying indexElement:(int) index idAnnotation:(int) idPin isFilterNoText:(BOOL) filterNoText arrayDataBase:(NSMutableArray *) arrayDataBase
{
    MapAnnotation *mp1 = [[MapAnnotation alloc] init];
    BOOL filter = YES;
    
    if(typeBuying == 0)
    {
        switch (type) {
            case 0:
                if([[arrayFilterData objectAtIndex:0] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameCategory:@"Музеи"];
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
            case 1:
                if([[arrayFilterData objectAtIndex:1] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameCategory:@"Рестораны"];
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
            case 2:
                if([[arrayFilterData objectAtIndex:2] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameCategory:@"Магазины"];
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
            case 4:
                if([[arrayFilterData objectAtIndex:3] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameCategory:@"Аэропорты"];
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
            case 5:
                if([[arrayFilterData objectAtIndex:3] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameCategory:@"Бары"];
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
            default:
                break;
        }
    }
    else
    {
        switch (type) {
            case 1:
                if([[arrayFilterData objectAtIndex:4] isEqualToString:@"0"] && filterNoText) filter=NO;
                [mp1 setNameColorPin:@"pin"];
                [mp1 setNameColorBigPin:@"pin"];
                break;
//            case 0:
//                if([[arrayFilterData objectAtIndex:5] isEqualToString:@"0"] && filterNoText) filter=NO;
//                [mp1 setNameColorPin:@"pin2"];
//                [mp1 setNameColorBigPin:@"pinBig2"];
//                break;
            default:
                break;
        }
    }

    if(filter)
    {
        location.latitude=[[[arrayDataBase objectAtIndex:index] objectForKey:@"latitude"] doubleValue];
        location.longitude=[[[arrayDataBase objectAtIndex:index] objectForKey:@"longitude"] doubleValue];
        [mp1 setCoordinate:location];
        [mp1 setTitle:[[arrayDataBase objectAtIndex:index] objectForKey:@"name"]];
        [mp1 setIdPin:[NSString stringWithFormat:@"%d",idPin]];
        
        [mapView addAnnotation:mp1];
        
        [arrayAnnotation addObject:mp1];
        
        if(MinX>location.latitude)
        {
            MinX = location.latitude;
        }
        if(MaxX<location.latitude)
        {
            MaxX = location.latitude;
        }
        if(MinY>location.longitude)
        {
            MinY = location.longitude;
        }
        if(MaxY<location.longitude)
        {
            MaxY = location.longitude;
        }
    }
}

-(void)filterForMap:(NSMutableArray *) arrayData
{
    MinX=MinY=1000;
    MaxX=MaxY=-1000;
    
    arrayFilterData=arrayData;
    
    if(arrayAnnotation != nil && [arrayAnnotation count]>0)
        [mapView removeAnnotations:arrayAnnotation];
    
    if(viewPinView != nil && [viewPinView count]>0)
        [viewPinView removeAllObjects];
  
    for(int i=0;i<([arrayDataBaseUniversal count]+[arrayDataBaseSightseening count]);i++)
    {
        [viewPinView addObject:[[ViewControllerMapsPinIcon alloc] init]];
    }
    
    if(![[arrayData objectAtIndex:([arrayData count]-1)] isEqualToString:@""])
    {
        int idPin = 1;
        
        for(int i=0;i<[arrayDataBaseUniversal count];i++)
        {
            if([[[arrayDataBaseUniversal objectAtIndex:i] objectForKey:@"name"] isEqualToString:[arrayData objectAtIndex:([arrayData count]-1)]])
            {
                [self filterAddAnnotationOrNot:[[[arrayDataBaseUniversal objectAtIndex:i] objectForKey:@"type"] intValue] isBuyingType:0 indexElement:i idAnnotation:idPin isFilterNoText:NO arrayDataBase:arrayDataBaseUniversal];
                
                idPin++;
                break;
            }
        }
        
        if(idPin==1)
        {
            for(int i = [arrayDataBaseUniversal count];i<([arrayDataBaseUniversal count]+[arrayDataBaseSightseening count]);i++)
            {
                if([[[arrayDataBaseSightseening objectAtIndex:(i-[arrayDataBaseUniversal count])] objectForKey:@"name"] isEqualToString:[arrayData objectAtIndex:([arrayData count]-1)]])
                {
                    int isBuying = [self retainIsBuy:[[[arrayDataBaseSightseening objectAtIndex:(i-[arrayDataBaseUniversal count])] objectForKey:@"id_sightseening"] intValue]];
                    [self filterAddAnnotationOrNot:isBuying isBuyingType:1 indexElement:i-[arrayDataBaseUniversal count] idAnnotation:idPin isFilterNoText:NO arrayDataBase:arrayDataBaseSightseening];
                }
            }
        }

    }
    else 
    {
        int idPin = 1;
        for(int i=0;i<[arrayDataBaseUniversal count];i++)
        {
            [self filterAddAnnotationOrNot:[[[arrayDataBaseUniversal objectAtIndex:i] objectForKey:@"type"] intValue] isBuyingType:0 indexElement:i idAnnotation:idPin isFilterNoText:YES arrayDataBase:arrayDataBaseUniversal];
            idPin++;
        }
        
        for(int i = idPin-1;i<([arrayDataBaseUniversal count]+[arrayDataBaseSightseening count]);i++)
        {
            int isBuying = [self retainIsBuy:[[[arrayDataBaseSightseening objectAtIndex:(i-[arrayDataBaseUniversal count])] objectForKey:@"id_sightseening"] intValue]];
            [self filterAddAnnotationOrNot:isBuying isBuyingType:1 indexElement:i-[arrayDataBaseUniversal count] idAnnotation:idPin isFilterNoText:YES arrayDataBase:arrayDataBaseSightseening];
            idPin++;
        }
    }
}
      
-(int)retainIsBuy:(int)id_sightseening 
{
    int isBuying = 0;
    if(id_sightseening == 11 && [MKStoreManager featureAPurchased])
    {
        isBuying = 1;
    }
    else if(id_sightseening == 12 && [MKStoreManager featureBPurchased])
    {
        isBuying = 1;
    }
    else if(id_sightseening != 11 && id_sightseening != 12)
    {
        isBuying = 1;
    }
    return isBuying;
}

-(void) dealloc
{
    [mapView removeAnnotations:arrayAnnotation];
    
    viewUserPin=nil;
    
    [arrayAnnotation removeAllObjects];
    arrayAnnotation = nil;
    
    [viewPinView removeAllObjects];
    viewPinView = nil;
    [numberColorPin removeAllObjects];
    numberColorPin = nil;
    
    [arrayDataBaseUniversal removeAllObjects];
    arrayDataBaseUniversal = nil;
    
    [arrayDataBaseSightseening removeAllObjects];
    arrayDataBaseSightseening = nil;

    buttonFilter = nil;
    
    [arrayFilterData removeAllObjects];
    arrayFilterData = nil;

    viewControllerUniversalViewElementList = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
