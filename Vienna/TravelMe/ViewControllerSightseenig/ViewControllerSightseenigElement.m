//
//  ViewControllerSightseenigElement.m
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerSightseenigElement.h"

@interface ViewControllerSightseenigElement ()

@end

@implementation ViewControllerSightseenigElement

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        arrayAnnotation = [[NSMutableArray alloc] init];
        
        dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;
        
        idSightseening = [[arrayData objectForKey:@"id_sightseening"] intValue];
        
        isBuying = YES;
//        if(idSightseening != 11 && idSightseening != 12)
//        {
//            isBuying = YES;
//        }
        
        arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:[NSString stringWithFormat:@"Select Element.* from Element,SightElements where SightElements.id_sightseening == %@ and Element.id == SightElements.id_element order by SightElements.number_sub",[arrayData objectForKey:@"id_sightseening"]]];
     
        
//        if([[arrayData objectForKey:@"isBuying"] isEqualToString:@"1"])
//            isBuying = YES;
//        else isBuying = NO;
        
        if (![[arrayData objectForKey:@"name"] isEqualToString:@"0"]) {
            name = [arrayData objectForKey:@"name"];
            description = [arrayData objectForKey:@"description"];
        }
        else {
            name = [[arrayDataBase objectAtIndex:0] objectForKey:@"name"];
            description = [[arrayDataBase objectAtIndex:0] objectForKey:@"description"];
        }
//        arrayDataBase = arrayData;
        // Custom initialization
        self.title = name;
    }
    return self;
}

- (UIImage *)convertImageToGrayScale:(UIImage *)image
{
    if(!image)
        return nil;
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    // Выбираем Черно-белую палитру
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // Создаем bitmap и контекст
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    // Создаем UIImage  
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    // Релизим палитру, битмап и контекст
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    // Возвращаем уже черно-белое изображение
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [labelName setText:name];
    [labelDescription setText:description];
    
//    NSMutableString * icon_name = [[NSMutableString alloc] initWithCapacity:10];
//    [icon_name appendFormat:[[arrayDataBase objectAtIndex:0] objectForKey:@"name_photo"]];
//    
//    [icon_name appendFormat:@"_480x692"];
     NSString * icon_name = @"";
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        icon_name =  [NSString stringWithFormat:@"%@_640x732",[[arrayDataBase objectAtIndex:0] objectForKey:@"name_photo"]];
        [labelDescription setFont:[UIFont systemFontOfSize:16]];
        [labelName setFont:[UIFont systemFontOfSize:18]];
    }
else
    icon_name =  [NSString stringWithFormat:@"%@_480x692",[[arrayDataBase objectAtIndex:0] objectForKey:@"name_photo"]];
    //NSLog(@"ICON NAME : %@\n FOR ELEMENT %@", icon_name,arrayDataBase);
    
    [imageSightseenig setImage:[UIImage imageNamed:icon_name]];
    
    [self setButtonBuy];
    // Do any additional setup after loading the view from its nib.
}
-(void) setButtonBuy
{
    if(isBuying)
    {
        [buttonSightseenig setBackgroundImage:[UIImage imageNamed:@"imageButtonBlue"] forState:UIControlStateNormal];
        [buttonSightseenig setTitle:@"Начать экскурсию" forState:UIControlStateNormal];
    }
    else 
    {
        saveImage = imageSightseenig.image;
        [imageSightseenig setImage:[self convertImageToGrayScale:imageSightseenig.image]];
        
        [buttonSightseenig setBackgroundImage:[UIImage imageNamed:@"imageButtonYellow"] forState:UIControlStateNormal];
        [buttonSightseenig setTitle:@"Купить экскурсию" forState:UIControlStateNormal];
        [buttonSightseenig setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonSightseenig setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [buttonSightseenig setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [buttonSightseenig setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonSightseenig setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [buttonSightseenig setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
}

-(void)prepareSightseening
{
    [arrayAnnotation removeAllObjects];
    int idPin = 1;
    for(int i=0;i<[arrayDataBase count];i++)
    {
        MapAnnotation *mp = [[MapAnnotation alloc] init];
        
        location.latitude=[[[arrayDataBase objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        location.longitude=[[[arrayDataBase objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
        
        [mp setCoordinate:location];
        [mp setTitle:[[arrayDataBase objectAtIndex:i] objectForKey:@"name"]];
        [mp setIsBuy:[NSString stringWithFormat:@"%d",isBuying?1:0]];
        [mp setIdPin:[NSString stringWithFormat:@"%d",idPin]];
        [mp setNameColorPin:[NSString stringWithFormat:@"pin"]];
        [mp setNameColorBigPin:[NSString stringWithFormat:@"pin"]];
        [arrayAnnotation addObject:mp];
        
        idPin++;
    }

    NSMutableDictionary * arrayData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:arrayAnnotation,@"arrayAnnotation",arrayDataBase, @"arrayDataBase",nil];
    [self.delegate StartSightseeningDelegate:arrayData];
}

-(IBAction)onStartSightseenig:(id)sender
{
    if(isBuying)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSightseening" object:[NSString stringWithFormat:@"%d",idSightseening]];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartBuying" object:[NSString stringWithFormat:@"%d",idSightseening]];
    }
}

- (void)productPurchased
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadAnnotationMap" object:nil];
    [imageSightseenig setImage:saveImage];
    [self setYesIsBuying];
    [self setButtonBuy];
    [self prepareSightseening];
}

// покупка не прошла, либо была отменена
- (void)failed
{
    
}

-(void) setYesIsBuying
{
    isBuying = YES;
    [imageSightseenig setImage:saveImage];
}

@end
