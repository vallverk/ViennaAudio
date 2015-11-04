//
//  ViewControllerGalleryPhotoElement.m
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerGalleryPhotoElement.h"

@implementation ViewControllerGalleryPhotoElement

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        photoName = [arrayData objectForKey:@"photoFull"];
        name = [arrayData objectForKey:@"name"];
        description = [arrayData objectForKey:@"description"];
        retina = ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0);
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [labelName setText:name];
    [labelDescription setText:description];
    if(retina) photoName = [NSString stringWithFormat:@"%@@2x", photoName ];
    NSString * file = [[NSBundle mainBundle] pathForResource:photoName ofType:@"png"];


    [progressPhoto setAsynchronous:YES];
    [progressPhoto setImageWithContentsOfFile:file];
}

@end
