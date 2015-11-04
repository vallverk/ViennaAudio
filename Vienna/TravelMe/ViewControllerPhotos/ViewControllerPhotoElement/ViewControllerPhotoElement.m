//
//  ViewControllerPhotoElement.m
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerPhotoElement.h"

@interface ViewControllerPhotoElement ()

@end

@implementation ViewControllerPhotoElement

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:[[_data objectAtIndex:_idPhoto] objectForKey:@"photoSmall"] ofType:@"png"];

    [image setAsynchronous:YES];
    [image setImageWithContentsOfFile:path];
}

-(IBAction)onClickPhoto:(id)sender;
{
    [self.delegate setDetailPhotoViewWithPhotoId:_idPhoto];
    
}

@end
