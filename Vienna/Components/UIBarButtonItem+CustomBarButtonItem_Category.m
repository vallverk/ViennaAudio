//
//  UIBarButtonItem+CustomBarButtonItem_Category.m
//  Recipe-book
//
//  Created by Olha Romanko on 29.01.13.
//  Copyright (c) 2013 Olha Romanko. All rights reserved.
//

#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@implementation UIBarButtonItem (CustomBarButtonItem_Category)

+ (UIBarButtonItem *)createSquareBarButtonItemWithTitle:(NSString *)t
                                        withButtonImage:(NSString *)btnIm
                                 withButtonPressedImage:(NSString *)btnPresIm
                                                 target:(id)tgt
                                                 action:(SEL)a
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:btnIm];
    UIImage *buttonPressedImage = [UIImage imageNamed:btnPresIm];

    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    // [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-4.0f, 1.0f, 0.0f, 0.0f)];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);

    
    [button setTitle:t forState:UIControlStateNormal];

    [button addTarget:tgt action:a forControlEvents:UIControlEventTouchUpInside];
   
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return [buttonItem autorelease];
}

@end
