//
//  ViewControllerOtherPrograms.m
//  TravelMe
//
//  Created by Viktor Bondarev on 04.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerOtherPrograms.h"

@interface ViewControllerOtherPrograms ()

@end

@implementation ViewControllerOtherPrograms

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *)arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        description = [arrayData objectForKey:@"description"];
        descriptionShort = [arrayData objectForKey:@"descriptionShort"];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [labelDescription setText:description];
    [labelDescriptionShort setText:descriptionShort];
    
    labelDescription.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelDescription.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    // Do any additional setup after loading the view from its nib.
}

@end
