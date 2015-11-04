//
//  ViewControllerPhotoElement.h
//  TravelMe
//
//  Created by Андрей Катюшин on 05.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//
#import "FXImageView.h"

@protocol ViewControllerPhotoElementDelegate <NSObject>
@optional
-(void)setDetailPhotoViewWithPhotoId:(int)idPhoto;
@end

@interface ViewControllerPhotoElement : UIViewController
{
    IBOutlet UIButton * photoElement;
    IBOutlet FXImageView*image;
    
}

@property  (nonatomic,strong)id<ViewControllerPhotoElementDelegate> delegate;
@property (nonatomic, assign) int idPhoto;
@property (nonatomic, strong) NSMutableArray * data;
-(IBAction)onClickPhoto:(id)sender;

@end
