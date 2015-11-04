//
//  ViewControllerUsefulPhonesListCell.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerUsefulPhonesListCell.h"

@interface ViewControllerUsefulPhonesListCell ()

@end

@implementation ViewControllerUsefulPhonesListCell

-(void)updateData
{
    [labelName setText:[_data objectForKey:@"name"]];
    [labelDescription setText:[_data objectForKey:@"description"]];
}

-(IBAction)onCallPhone:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[_data objectForKey:@"phone"]]]];
}


@end
