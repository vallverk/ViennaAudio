//
//  ViewControllerUserfulInformationCell.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerUserfulInformationCell.h"

@interface ViewControllerUserfulInformationCell ()

@end

@implementation ViewControllerUserfulInformationCell

-(void)updateData
{
    [imageIcon setImage:[UIImage imageNamed:[_data objectForKey:@"imageName"]]];
    [labelName setText:[_data objectForKey:@"name"]];
}

@end
