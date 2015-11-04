//
//  UICustomSwitch.h
//
//  Created by Hardy Macia on 10/28/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
//  Code can be freely redistruted and modified as long as the above copyright remains.
//

#import <Foundation/Foundation.h>


@interface UICustomSwitch : UISlider
{
	BOOL isOn;
	UIView *clippingView;
	UILabel *rightLabel;
	UILabel *leftLabel;
	BOOL m_touchedSelf;
    
    NSInteger ElementWidth;
    NSInteger ElementHeight;
    
    NSString * OnChangeMessage;
}
@property (nonatomic, readonly) NSString * OnChangeMessage;

-(id)initWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2;
-(void)setLeftText:(NSString *)value;
-(void)setRightText:(NSString *)value;
-(void)setOn:(BOOL)on animated:(BOOL)animated;
-(BOOL)getIsOn;

@end
