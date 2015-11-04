//
//  ViewControllerUserfulInformationCell.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//


@interface ViewControllerUserfulInformationCell : UITableViewCell
{
    IBOutlet UIImageView * imageIcon;
    IBOutlet UILabel * labelName;
}
@property (strong,nonatomic) NSMutableDictionary*data;
-(void)updateData;

@end
