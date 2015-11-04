//
//  ViewControllerViewSightseenigElement.m
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerViewSightseenigElement.h"

@interface ViewControllerViewSightseenigElement ()

@end

@implementation ViewControllerViewSightseenigElement

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        name = [arrayData objectForKey:@"name"];
        description = [arrayData objectForKey:@"description"];
        
        name_photo = [[NSMutableString alloc] initWithCapacity:10];
        [name_photo appendFormat:[arrayData objectForKey:@"name_photo"]];
        
        [name_photo appendFormat:@"_640x732"];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [labelName setText:name];
    [labelDescription setText:description];

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        [labelDescription setFont:[UIFont systemFontOfSize:16]];
        [labelName setFont:[UIFont systemFontOfSize:18]];
    }

    
    [photoName setImage:[UIImage imageNamed:name_photo]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
