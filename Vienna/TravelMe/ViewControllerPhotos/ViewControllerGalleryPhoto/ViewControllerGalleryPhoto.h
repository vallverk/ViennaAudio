//
//  ViewControllerGalleryPhoto.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "AppDelegate.h"
#import "SoGeViewHorizontalTabGallery.h"
#import "ViewControllerGalleryPhotoElement.h"

@interface ViewControllerGalleryPhoto : UIViewController
{
   // IBOutlet SoGeViewHorizontalTabGallery * gallery;
    
    NSMutableArray * data;
    int numberPhoto;
    NSMutableArray*controllers;
}

@property (nonatomic, strong) SoGeViewHorizontalTabGallery * gallery;
@property (nonatomic, assign) int idPhoto;
-(void)setData:(NSMutableArray*)data;
-(void)releaseGallery;
-(IBAction)onClickLeftButton:(id)sender;
-(IBAction)onClickRightButton:(id)sender;


@end
