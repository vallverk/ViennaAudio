//
//  ViewControllerUniversalViewElementList.m
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerUniversalViewElementList.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"
#import "UIImage+Scale.h"

@interface ViewControllerUniversalViewElementList ()

@end

@implementation ViewControllerUniversalViewElementList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }

    return self;
}

-(void) setData:(NSMutableDictionary *) arrayData
{
    name = [arrayData objectForKey:@"name"];
    description = [arrayData objectForKey:@"description"];
    workdays = [arrayData objectForKey:@"workdays"];
    freedays = [arrayData objectForKey:@"freedays"];
    contacts = [arrayData objectForKey:@"contacts"];
    site = [arrayData objectForKey:@"site"];

    // условие проверки на случай незаполнения полей связанных с режимом работы
    // при их отсутствии на экране будет выводится 0
    if([workdays  isEqualToString: @"0"]) workdays=@"";
    if([freedays  isEqualToString: @"0"]||[freedays  isEqualToString: @"0 "]) freedays=@"";
    if(([workdays  isEqualToString: @"0"])&&([freedays  isEqualToString: @"0"])) [labelOperationMode setHidden:YES];
    if([contacts  isEqualToString: @"0"])
    {
        [labelContactsInforamtion setHidden:YES];
        contacts=@"";
    }
    if([site  isEqual: @"0"])
    {
        [labelSiteInformation setHidden:YES];
        site=@"";
    }

    location.latitude = [[arrayData objectForKey:@"latitude"] doubleValue];
    location.longitude = [[arrayData objectForKey:@"longitude"] doubleValue];

    adress = [arrayData objectForKey:@"adress"];
    name_photo = [arrayData objectForKey:@"name_photo"];

    type = [[arrayData objectForKey:@"type"] integerValue];
    // Custom initialization

    self.title = name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [viewIconSelect setUserInteractionEnabled:NO];
    NSArray * viewsIconSelectPin = [viewIconSelect subviews];
    [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setText:adress];
    [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

    [labelName setText:name];
    [labelDescription setText:description];
    [labelWorkDays setText:workdays];
    [labelFreeDays setText:freedays];
    [labelContacts setTitle:contacts forState:UIControlStateNormal];
    [labelSite setTitle:site forState:UIControlStateNormal];

    //[photo setFrame:CGRectMake(0, 0, appWidth, photo.frame.size.height)];

   // NSString *path = [[NSBundle mainBundle] pathForResource:name_photo ofType:@"png"];
   // [photo setImageWithContentsOfFile:path];
    
    labelDescription.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelDescription.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    labelFreeDays.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelFreeDays.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    labelWorkDays.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelWorkDays.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    labelDescription.layer.shadowOpacity = 1.0f;
//    labelDescription.layer.shadowRadius = 1.0f;

  //  [self updateView];

    mapView.showsUserLocation = YES;
    
    MapAnnotation *mp = [[MapAnnotation alloc] init];
    
    [mp setCoordinate:location];
    [mp setTitle:name];

    [mp setNameColorPin:@"pin"];
    [mp setNameColorBigPin:@"pin"];

    [mapView addAnnotation:mp];
    
    double MinX,MinY,MaxX,MaxY;
    MinX = location.latitude-0.01;
    MaxX = location.latitude+0.01;
    MinY = location.longitude-0.01;
    MaxY = location.longitude+0.01;
    
    MKCoordinateRegion region = {{(MaxX-MinX)/2+MinX, (MaxY-MinY)/2+MinY}, {0.0f, 0.0f}}; 
    region.span.longitudeDelta = (MaxY-MinY); region.span.latitudeDelta = (MaxX-MinX);
    [mapView setRegion:region animated:NO];
    [mapView regionThatFits:region];

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{

        UIImage*img =[UIImage imageNamed:name_photo];
        img =[UIImage imageWithImage:img scaledToWidth:appWidth];
        [photo setImage:img];

        dispatch_async(dispatch_get_main_queue(), ^{

            [photo setFrame:CGRectMake(0, 0, appWidth, img.size.height)];
            [self updateView];
        });
    });

}

-(void)viewDidDisappear:(BOOL)animated
{
    [logo setHidden:NO];
    [photo setImage:nil];
    [scroll setContentOffset:CGPointZero animated:NO];
}

-(void) updateView
{
    if (photo.image != nil) {
        [logo setHidden:YES];
    }
    [labelName setFrame:CGRectMake(0, photo.frame.size.height+5, appWidth, labelName.frame.size.height)];

    [labelDescription setFrame:CGRectMake(labelDescription.frame.origin.x, labelName.frame.origin.y+labelName.frame.size.height+10, labelDescription.frame.size.width, labelDescription.contentSize.height)];

    if([workdays length] != 0 || [freedays length] != 0)
    {
        [labelOperationMode setFrame:CGRectMake(labelOperationMode.frame.origin.x, labelDescription.frame.origin.y+labelDescription.frame.size.height+10, labelOperationMode.frame.size.width, labelOperationMode.frame.size.height)];
    }
    else {
        [labelOperationMode setFrame:CGRectMake(labelOperationMode.frame.origin.x,labelDescription.frame.origin.y+labelDescription.frame.size.height,0,0)];
    }

    if([freedays length] != 0)
    {
        [labelFreeDays setFrame:CGRectMake(labelFreeDays.frame.origin.x, labelOperationMode.frame.origin.y+labelOperationMode.frame.size.height, labelFreeDays.frame.size.width, labelFreeDays.contentSize.height)];
    }
    else
    {
        [labelFreeDays setFrame:CGRectMake(labelFreeDays.frame.origin.x, labelOperationMode.frame.origin.y+labelOperationMode.frame.size.height+10, 0, 0)];
    }

    if([workdays length] != 0)
    {
        [labelWorkDays setFrame:CGRectMake(labelWorkDays.frame.origin.x, labelFreeDays.frame.origin.y+labelFreeDays.frame.size.height-10, labelWorkDays.frame.size.width, labelWorkDays.contentSize.height)];
    }
    else
    {
        [labelWorkDays setFrame:CGRectMake(labelWorkDays.frame.origin.x, labelOperationMode.frame.origin.y+labelOperationMode.frame.size.height, 0, 0)];
    }

    if([contacts length] != 0)
    {
        [labelContactsInforamtion setFrame:CGRectMake(labelContactsInforamtion.frame.origin.x, labelWorkDays.frame.origin.y+labelWorkDays.frame.size.height+10, labelContactsInforamtion.frame.size.width,labelContactsInforamtion.frame.size.height)];
        [labelContacts setFrame:CGRectMake(labelContacts.frame.origin.x, labelContactsInforamtion.frame.origin.y+labelContactsInforamtion.frame.size.height+10, labelContacts.frame.size.width,labelContacts.frame.size.height)];
    }
    else
    {
        [labelContactsInforamtion setFrame:CGRectMake(labelWorkDays.frame.origin.x,labelWorkDays.frame.origin.y+labelWorkDays.frame.size.height,0,0)];
        [labelContacts setFrame:CGRectMake(labelContacts.frame.origin.x, labelContactsInforamtion.frame.origin.y+labelContactsInforamtion.frame.size.height, 0,0)];
    }

    if([site length] != 0)
    {
        [labelSiteInformation setFrame:CGRectMake(labelSiteInformation.frame.origin.x, labelContacts.frame.origin.y+labelContacts.frame.size.height+10, labelSiteInformation.frame.size.width,labelSiteInformation.frame.size.height)];
        [labelSite setFrame:CGRectMake(labelSite.frame.origin.x, labelSiteInformation.frame.origin.y+labelSiteInformation.frame.size.height+10, labelSite.frame.size.width,labelSite.frame.size.height)];
    }
    else {
        [labelSiteInformation setFrame:CGRectMake(labelContacts .frame.origin.x, labelContacts.frame.origin.y+labelContacts.frame.size.height, 0,0)];
        [labelSite setFrame:CGRectMake(labelSite.frame.origin.x, labelSiteInformation.frame.origin.y+labelSiteInformation.frame.size.height, 0,0)];
    }

    [mapView setFrame:CGRectMake(mapView.frame.origin.x, labelSite.frame.origin.y+labelSite.frame.size.height+10, mapView.frame.size.width, mapView.frame.size.height)];

    [viewMain setFrame:CGRectMake(0, 0, self.view.frame.size.width,mapView.frame.origin.y+mapView.frame.size.height)];

    [scroll setContentSize:CGSizeMake(viewMain.frame.size.width, viewMain.frame.size.height+50)];
  //  [scroll setContentOffset:scroll.contentOffset animated:YES];

}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onCallPhone:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",contacts]]];
}

-(IBAction)onCallSite:(id)sender
{
//    if([data lengthOfBytesUsingEncoding:NSStringEncodingConversionAllowLossy]>5 && [[data substringToIndex:4] isEqualToString:@"http"]==YES) =data;
    if([[site substringToIndex:4] isEqualToString:@"http"]==NO)   
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",site]]];
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:site]];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = nil;
    
    if (annotation != mapView.userLocation)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Площадь Ленина,д.7"];
        if (annotationView) {
            annotationView.canShowCallout=NO;
            [annotationView setImage:[UIImage imageNamed:[((MapAnnotation *) annotation) nameColorPin]]];
            [annotationView setCenterOffset:CGPointMake(0, -annotationView.frame.size.height/2+3)];
            
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
            
            return annotationView;
        }
        
    }
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)map didAddAnnotationViews:(NSArray *)views
{
    if((( MKAnnotationView *)[views objectAtIndex:0]).annotation == mapView.userLocation)
    {
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
    if (view.annotation != mapView.userLocation)
    {
        [view setImage:[UIImage imageNamed:[((MapAnnotation *) view.annotation) nameColorBigPin]]];
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-4,view.frame.size.width,view.frame.size.height)];
        
        [mapView setCenterCoordinate:((MapAnnotation *) view.annotation).coordinate animated:YES];
        [((MKAnnotationView *) view) addSubview:viewIconSelect];
         [viewIconSelect setFrame:CGRectMake(0, 0, 147, 42)];
        [viewIconSelect setFrame:CGRectMake(viewIconSelect.frame.origin.x-(viewIconSelect.frame.size.width-view.frame.size.width)/2-3, viewIconSelect.frame.origin.y-viewIconSelect.frame.size.height, viewIconSelect.frame.size.width, viewIconSelect.frame.size.height)];
        
        NSArray * viewsIconSelectPin = [viewIconSelect subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setText:adress];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

    }
    else
    {
        [mapView setCenterCoordinate:((MapAnnotation *) view.annotation).coordinate animated:YES];
        [((MKAnnotationView *) view) addSubview:viewIconSelect];
        [viewIconSelect setFrame:CGRectMake(0, 0, 147, 42)];
        [viewIconSelect setFrame:CGRectMake(viewIconSelect.frame.origin.x-(viewIconSelect.frame.size.width-view.frame.size.width)/2-3, viewIconSelect.frame.origin.y-viewIconSelect.frame.size.height, viewIconSelect.frame.size.width, viewIconSelect.frame.size.height)];
        
        NSArray * viewsIconSelectPin = [viewIconSelect subviews];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setText:@"Текущая позиция"];
        [((UILabel *)[viewsIconSelectPin objectAtIndex:1]) setTextColor:[UIColor blackColor]];

    }
}

- (void)mapView:(MKMapView *)map didDeselectAnnotationView:(MKAnnotationView *)view
{
    if (view.annotation != mapView.userLocation)
    {
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+4,view.frame.size.width,view.frame.size.height)];
        [view setImage:[UIImage imageNamed:[((MapAnnotation *) view.annotation) nameColorPin]]];
    }
    [viewIconSelect removeFromSuperview];
    [viewIconSelect setFrame:CGRectMake(0,0,147,42)];
}

@end
