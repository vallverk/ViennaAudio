//
//  ViewControllerGalleryPhotoElement.h
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//
#import "FXImageView.h"
@interface ViewControllerGalleryPhotoElement : UIViewController
{
    IBOutlet FXImageView*progressPhoto;
    IBOutlet UILabel * labelName;
    IBOutlet UILabel * labelDescription;
    BOOL retina;
    NSString * photoName,*name,*description;
    IBOutlet UIActivityIndicatorView*actInd;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *) arrayData;

@end
