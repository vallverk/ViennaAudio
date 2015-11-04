//
//  ViewControllerViewSightseenigElement.h
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//


@interface ViewControllerViewSightseenigElement : UIViewController
{
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelDescription;
    IBOutlet UIImageView * photoName;
    
    NSMutableString * name,*description,*name_photo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData;

@end
