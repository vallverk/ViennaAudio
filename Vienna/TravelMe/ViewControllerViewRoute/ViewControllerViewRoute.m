//
//  ViewControllerViewRoute.m
//  TravelMe
//
//  Created by Viktor Bondarev on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerViewRoute.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@interface ViewControllerViewRoute ()

@end

@implementation ViewControllerViewRoute

@synthesize mapView;
@synthesize routeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData isSightseening:(BOOL) isSightseening
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {        
        viewUserPin = [[ViewControllerMapsPinIcon alloc] init];
        arrayAnnotation = [arrayData objectForKey:@"arrayAnnotation"];
        arrayDataBase = [arrayData objectForKey:@"arrayDataBase"];
        previousPin = [[MKAnnotationView alloc] init];
        if (isSightseening) {
            points = nil;
        }
        else {
            points = [arrayData objectForKey:@"pointsAnnotation"];
        }
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setFrame:CGRectMake(0, 0, appWidth, appHeight-200)];

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectPin:) name:@"SelectPin" object:nil];
    
//    timerStartBuying = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(startBuyingNO) userInfo:nil repeats:NO];
    
    mapView.showsUserLocation = YES;
    
    
    firstSelect = YES;
    
    selectPin = 0;
//    double MinDistance = 100000;
//    for(int i=0;i<[points count];i++)
//    {
//        CLLocation* location = [points objectAtIndex:i];
//        double distance = sqrt(location.coordinate.latitude*location.coordinate.latitude+location.coordinate.longitude*location.coordinate.longitude);
//        if(MinDistance > distance)
//        {
//            MinDistance = distance;
//            selectPin = i;
//        }
//    }
    
    viewPinView = [[NSMutableArray alloc] init];
    for(int i=0;i<[arrayAnnotation count];i++)
    {
        [viewPinView addObject:[[ViewControllerMapsPinIcon alloc] init]];
    }
    
    for(int i=0;i<[arrayAnnotation count];i++)
    {
        //NSLog(@"%@",[(MapAnnotation *)[arrayAnnotation objectAtIndex:i] idPin]);
        [mapView addAnnotation:(MapAnnotation *)[arrayAnnotation objectAtIndex:i]];
    }
    
//    viewBuy setUserInteractionEnabled:<#(BOOL)#>
    
//    [ select:[arrayAnnotation objectAtIndex:selectPin]];
    
    isSelectRoute = NO;

    [segmentControl.layer setCornerRadius:5];
    
    if([[(MapAnnotation *)[arrayAnnotation objectAtIndex:selectPin] isBuy] isEqualToString:@"1"] && points)
        controller = [[ViewControllerViewSightseenig alloc] initWithNibName:@"ViewControllerViewSightseenig" bundle:nil arrayData:nil arrayRouteData:arrayDataBase];
    else if(points)
        controller = [[ViewControllerViewSightseenig alloc] initWithNibName:@"ViewControllerViewSightseenig" bundle:nil arrayData:nil arrayRouteData:arrayDataBase];
    else {
        [segmentControl setTitle:@"Карта" forSegmentAtIndex:0];
        controller = [[ViewControllerViewSightseenig alloc] initWithNibName:@"ViewControllerViewSightseenig" bundle:nil arrayData:arrayDataBase arrayRouteData:nil];
    }


    [self.view addSubview:controller.view];
    
    [viewSwitch removeFromSuperview];
    [self.view addSubview:viewSwitch];

    [mapView removeFromSuperview];
    [self.view addSubview:mapView];
    
    [viewBuy removeFromSuperview];
    [self.view addSubview:viewBuy];
    
    [mapView setHidden:NO];

    [segmentControl setTintColor:[UIColor redColor]];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    [segmentControl setBackgroundColor:[UIColor whiteColor]];

  //  [self onClickButtonRoute:nil];
    [segmentControl setSelectedSegmentIndex:0];
    
//    if(isSelectRoute)
//
//        [buttonRoute setBackgroundImage:[UIImage imageNamed:@"imageSwitchYellow"] forState:UIControlStateNormal];
//        [buttonSightseenig setBackgroundImage:[UIImage imageNamed:@"imageSwitchBlue"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [buttonRoute setBackgroundImage:[UIImage imageNamed:@"imageSwitchBlue"] forState:UIControlStateNormal];
//        [buttonSightseenig setBackgroundImage:[UIImage imageNamed:@"imageSwitchYellow"] forState:UIControlStateNormal];
//    }
    
    double MinX,MinY,MaxX,MaxY;
    if([arrayAnnotation count]>0)
    {
        MinX=MaxX=((MapAnnotation *)[arrayAnnotation objectAtIndex:0]).coordinate.latitude;
        MinY=MaxY=((MapAnnotation *)[arrayAnnotation objectAtIndex:0]).coordinate.longitude;
        for(int i=0;i<[arrayAnnotation count];i++)
        {
            CLLocationCoordinate2D location = ((MapAnnotation *)[arrayAnnotation objectAtIndex:i]).coordinate;
            
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
        
        
        if([arrayAnnotation count]>1)
        {
            MKCoordinateRegion region = {{(MaxX-MinX)/2+MinX, (MaxY-MinY)/2+MinY}, {0.0f, 0.0f}};
            region.span.longitudeDelta = (MaxY-MinY); region.span.latitudeDelta = (MaxX-MinX);
            [mapView setRegion:region animated:NO];
        }
        else 
        {
            MKCoordinateRegion region = {{(MaxX-MinX)/2+MinX, (MaxY-MinY)/2+MinY}, {0.0f, 0.0f}};
            region.span.longitudeDelta = 0.02; region.span.latitudeDelta = 0.02;
            [mapView setRegion:region animated:NO];
        }
        
    }
    
    if(points)
        self.routeView = [[UNRouteView alloc] initWithRoute:points mapView:mapView];
//    [mapView selectAnnotation:(MapAnnotation *) [arrayAnnotation objectAtIndex:selectPin] animated:NO];
    // Do any additional setup after loading the view from its nib.

    [self.view bringSubviewToFront:segmentControl];
}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title =[(NSMutableDictionary*)[arrayDataBase objectAtIndex:0] objectForKey:@"name"];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

    [super viewWillDisappear:animated];
}


//-(void) startBuyingNO
//{
//    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) setStartBuying:@"0"];
//}

-(IBAction)onClickButtonRoute:(id)sender
{
//    [mapView selectAnnotation:(MapAnnotation *) [arrayAnnotation objectAtIndex:[controller getSelectPin]] animated:NO];
//    isSelectRoute = NO;
    

}

-(void) SelectPin:(id) text
{
    int select = [(NSString *)[text object] integerValue];
    [mapView selectAnnotation:(MapAnnotation *) [arrayAnnotation objectAtIndex:select] animated:NO];
}

-(IBAction) segmentControlChangeValue:(id)sender
{
    if (segmentControl.selectedSegmentIndex==0) {

        NSArray * subviewsPlayer = [controller.view subviews];
        [[subviewsPlayer objectAtIndex:0] setHidden:YES];
        [mapView setHidden:NO];
    }
    else
    {
        NSArray * subviewsPlayer = [controller.view subviews];
        [[subviewsPlayer objectAtIndex:0] setHidden:NO];
        [mapView setHidden:YES];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{ 
	routeView.hidden = YES;
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    routeView.hidden = NO;
	[routeView setNeedsDisplay];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = nil;
    
    if (annotation != mapView.userLocation)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        if (annotationView) {
            annotationView.canShowCallout=NO;
            if([[((MapAnnotation *)annotationView.annotation) isBuy] isEqualToString:@"1"]) [annotationView setImage:[UIImage imageNamed:@"pin"]];
            else [annotationView setImage:[UIImage imageNamed:@"pin"]];
            
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
        return  nil;
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Площадь Ленина,д.7"];
        if (annotationView) {
            annotationView.canShowCallout=NO;
            [annotationView setImage:[UIImage imageNamed:@"userPin"]];
            
            [annotationView setCenterOffset:CGPointMake(0, -annotationView.frame.size.height/2+3)];
            
            [viewUserPin.view setFrame:CGRectMake(0,0,147,42)];
            [viewUserPin.view setHidden:YES];
            [annotationView addSubview:viewUserPin.view];
            
            [viewUserPin.view setFrame:CGRectMake(viewUserPin.view.frame.origin.x-(viewUserPin.view.frame.size.width-annotationView.frame.size.width)/2-1, viewUserPin.view.frame.origin.y-viewUserPin.view.frame.size.height, 
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



- (void)mapView:(MKMapView *)map didAddAnnotationViews:(NSArray *)views
{
    if([views count]==[arrayAnnotation count] && (( MKAnnotationView *) [views objectAtIndex:0]).annotation != mapView.userLocation)
    {
        for(int i=0;i<[views count];i++)
        {
            if(i==0)
            {
                previousPin = [views objectAtIndex:0];  
            }
        }
        [mapView selectAnnotation:(MapAnnotation *) [arrayAnnotation objectAtIndex:selectPin] animated:NO];
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
    
    [mapView setCenterCoordinate:((MapAnnotation *) view.annotation).coordinate animated:YES];
    
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
    
    if(view.annotation != mapView.userLocation)
    {
        selectPin = [[((MapAnnotation *)view.annotation) idPin] integerValue]-1;
    
        if(previousPin.annotation == view.annotation || firstSelect)
        {
            if(isSelectRoute)
            {
                [controller selectPin:selectPin];
            }
            
            [segmentControl setSelectedSegmentIndex:1];
            [self segmentControlChangeValue:segmentControl];
            
            if([[((MapAnnotation *)view.annotation) isBuy] isEqualToString:@"1"]) 
            {
                [viewBuy setHidden:YES];
                NSArray * subviewsPlayer = [controller.view subviews];
                [[subviewsPlayer objectAtIndex:1] setHidden:NO];
            }
            else 
            {
                [viewBuy setHidden:NO];
                NSArray * subviewsPlayer = [controller.view subviews];
                [[subviewsPlayer objectAtIndex:1] setHidden:YES];
            }
        }
        
        [view setImage:[UIImage imageNamed:[((MapAnnotation *) view.annotation) nameColorBigPin]]];
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-4,view.frame.size.width,view.frame.size.height)];
        
        ViewControllerMapsPinIcon * iconPin = (ViewControllerMapsPinIcon *)[viewPinView objectAtIndex:([((MapAnnotation *) view.annotation).idPin integerValue]-1)];
        [iconPin.view setHidden:NO];
        [iconPin.view setFrame:CGRectMake(0, 0, 147, 42)];
        [iconPin.view setFrame:CGRectMake(iconPin.view.frame.origin.x - (iconPin.view.frame.size.width-view.frame.size.width)/2-3, iconPin.view.frame.origin.y-iconPin.view.frame.size.height,iconPin.view.frame.size.width, iconPin.view.frame.size.height)];
    
        NSArray * viewsIconSelectPin = [iconPin.view subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

    }
    else
    {
        selectPin = -1;
        [viewUserPin.view setHidden:NO];
        NSArray * viewsIconSelectPin = [viewUserPin.view subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];
    }
    
    previousPin = view;
    isSelectRoute = YES;
    firstSelect = NO;
}

-(void) dealloc
{
    viewUserPin = nil;
    previousPin = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
