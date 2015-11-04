//
//  ViewControllerUniversalListCell.m
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerUniversalListCell.h"

@interface ViewControllerUniversalListCell ()

@end

@implementation ViewControllerUniversalListCell

-(void)updateData
{
    NSMutableString * icon_name = [[NSMutableString alloc] initWithCapacity:10];
    [icon_name appendFormat:[_data objectForKey:@"name_photo"]];

    [icon_name appendFormat:@"_short"];
  //  [imageIcon setImage:[UIImage imageNamed:icon_name]];
    NSString *path = [[NSBundle mainBundle] pathForResource:icon_name ofType:@"png"];
    [imageIcon setImageWithContentsOfFile:path];
    if([[_data objectForKey:@"type"] integerValue] == 3)
    {
        [imageIcon setFrame:CGRectMake(imageIcon.frame.origin.x+10, imageIcon.frame.origin.y, 35, 35)];
    }
    else
    {
        [imageIcon layer].cornerRadius =  1.0f;
        [imageIcon layer].masksToBounds = YES;
        [imageIcon layer].borderWidth = 1.0f;
        [imageIcon layer].borderColor = [UIColor blackColor].CGColor;
    }

    [labelName setText:[_data objectForKey:@"name"]];
    [labelDescription setText:[_data objectForKey:@"descriptionShort"]];
}

@end
