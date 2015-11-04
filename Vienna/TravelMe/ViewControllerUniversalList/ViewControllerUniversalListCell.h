//
//  ViewControllerUniversalListCell.h
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FXImageView.h"

@interface ViewControllerUniversalListCell : UITableViewCell
{
    IBOutlet FXImageView * imageIcon;
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelDescription;
}
@property (strong,nonatomic) NSMutableDictionary*data;
-(void)updateData;
@end
