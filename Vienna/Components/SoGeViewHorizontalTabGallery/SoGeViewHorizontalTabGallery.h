//
//  ViewHorizontalTabGallery.h
//  OAK
//
//  Created by Viktor Bondarev on 19.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoGeViewHorizontalTabGallery : UIView<UIScrollViewDelegate>
{
    NSMutableArray * controllers;
    UIScrollView * scrollView;
    
    UIImage * tabsBackgroundImage;
    UIImage * tabImage;
    UIImage * tabActiveImage;
    CGSize tabsSize;
    UIView * viewTabs;
    UIImageView * imageViewTabsBackground;
    NSMutableArray * buttons;
    
    NSInteger current;
    NSInteger elementWidth;
    
    BOOL isTouchStart;
    CGFloat lastPosition;
}
-(void)setTabsBackgroundImage:(UIImage *)image WithSize:(CGSize)size;
-(void)setTabsImage:(UIImage *)image WithActiveTabImage:(UIImage *)imageActive;
-(void)setElementWidth:(NSInteger)width;

-(void)addController:(UIViewController *)controller;
-(void)addControllerWihtoutOffset:(UIViewController *)controller;
-(void)setActiveController:(UIViewController *)controller;
-(UIViewController *)getActiveController;
-(UIViewController *)getController:(int) id_controller;
-(void)setActiveControllerAtIndex:(NSInteger)index;
-(NSInteger)getIndexActiveController;
-(BOOL)getIsTouchStart;
-(void)EndScrollingAnimation;
-(void)hide;
@end
