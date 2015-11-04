//
//  ViewControllerUsefulPhonesListCell.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//


@interface ViewControllerUsefulPhonesListCell : UITableViewCell
{
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelDescription;
}

-(IBAction)onCallPhone:(id)sender;
@property (strong,nonatomic) NSMutableDictionary*data;
-(void)updateData;

@end
