//
//  ViewControllerOtherPrograms.h
//  TravelMe
//
//  Created by Viktor Bondarev on 04.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewControllerOtherPrograms :UIViewController
{
    IBOutlet UILabel * labelDescriptionShort;
    IBOutlet UITextView * labelDescription;
    
    NSString * descriptionShort, *description;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableDictionary *)arrayData;

@end
