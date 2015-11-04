//
//  UIBarButtonItem+CustomBarButtonItem_Category.h
//  Recipe-book
//
//  Created by Olha Romanko on 29.01.13.
//  Copyright (c) 2013 Olha Romanko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomBarButtonItem_Category)
+ (UIBarButtonItem *)createSquareBarButtonItemWithTitle:(NSString *)t
                                        withButtonImage:(NSString *)btnIm
                                 withButtonPressedImage:(NSString *)btnPresIm
                                                 target:(id)tgt
                                                 action:(SEL)a;
@end
