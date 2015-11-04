//
//  UICustomSwitch.m
//
//  Created by Hardy Macia on 10/28/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
//  Code can be freely redistruted and modified as long as the above copyright remains.
//

#import "UICustomSwitch.h"

@implementation UICustomSwitch
@synthesize OnChangeMessage;

-(void)initConstsWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2
{
    ElementWidth = 94;
    ElementHeight = 30;

    OnChangeMessage = [NSString stringWithFormat:@"UICustomSwitch.OnChangeValue_%lf",[[[NSDate alloc] init] timeIntervalSince1970]];

    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, ElementWidth, ElementHeight)];

    self.backgroundColor = [UIColor clearColor];

    [self setThumbImage:[UIImage imageNamed:@"imageThumb"] forState:UIControlStateNormal];
    [self setMinimumTrackImage:[[UIImage imageNamed:@"imageBackgroundSlider"]stretchableImageWithLeftCapWidth:10.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [self setMaximumTrackImage:[[UIImage imageNamed:@"imageBackgroundSlider"]stretchableImageWithLeftCapWidth:10.0f topCapHeight:0.0f] forState:UIControlStateNormal];

    self.minimumValue = 0;
    self.maximumValue = 1;
    self.continuous = NO;

    isOn = YES;
    self.value = 1.0;

    clippingView = [[UIView alloc] initWithFrame:CGRectMake(4,0,ElementWidth - 8,ElementHeight)];
    clippingView.clipsToBounds = YES;
    clippingView.userInteractionEnabled = NO;
    clippingView.backgroundColor = [UIColor clearColor];
    [self addSubview:clippingView];

    leftLabel = [[UILabel alloc] init];
    leftLabel.frame = CGRectMake(0, 0, ElementWidth / 2, ElementHeight);
    leftLabel.text = tag1;
    leftLabel.textAlignment = UITextAlignmentCenter;
    leftLabel.font = [UIFont boldSystemFontOfSize:11];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    leftLabel.shadowOffset = CGSizeMake(0,1);
    [clippingView addSubview:leftLabel];

    rightLabel = [[UILabel alloc] init];
    rightLabel.frame = CGRectMake(ElementWidth, 0, ElementWidth / 2, ElementHeight);
    rightLabel.text = tag2;
    rightLabel.textAlignment = UITextAlignmentCenter;
    rightLabel.font = [UIFont boldSystemFontOfSize:11];
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    rightLabel.shadowOffset = CGSizeMake(0,1);
    [clippingView addSubview:rightLabel];
}

-(id)init{return [self initWithLeftText:@"Показать" andRight:@"Скрыть"];}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){[self initConstsWithLeftText:@"Показать" andRight:@"Скрыть"];}
    return self;
}
-(id)initWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2
{
    self = [super init];
    if (self) {[self initConstsWithLeftText:tag1 andRight:tag2];}
    return self;
}
-(id)initWithFrame:(CGRect)rect
{   
    self = [self initWithFrame:rect];
    if(self){[self initConstsWithLeftText:@"Показать" andRight:@"Скрыть"];[self setFrame:CGRectMake(rect.origin.x, rect.origin.y, ElementWidth, ElementHeight)];}
	return self;
}
-(void)setFrame:(CGRect)frame{[super setFrame:CGRectMake(frame.origin.x, frame.origin.y, ElementWidth, ElementHeight)];}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [clippingView removeFromSuperview];
    [self addSubview:clippingView];

    CGFloat thumbWidth = self.currentThumbImage.size.width;
    CGFloat switchWidth = self.bounds.size.width;
    CGFloat labelWidth = switchWidth - thumbWidth;
    CGFloat inset = clippingView.frame.origin.x;

    NSInteger xPos = self.value * labelWidth - labelWidth - inset;
    leftLabel.frame = CGRectMake(xPos, 0, labelWidth, ElementHeight);

    xPos = switchWidth + (self.value * labelWidth - labelWidth) - inset; 
    rightLabel.frame = CGRectMake(xPos, 0, labelWidth, ElementHeight);
}

-(void)setOn:(BOOL)turnOn animated:(BOOL)animated;
{
	isOn = turnOn;
	if (animated){[UIView beginAnimations:@"UICustomSwitch" context:nil];[UIView setAnimationDuration:0.2];}
	if(isOn) self.value = 1.0;
	else self.value = 0.0;
	if (animated)[UIView commitAnimations];
    [[NSNotificationCenter defaultCenter] postNotificationName: OnChangeMessage object:nil];
}
-(void)setOn:(BOOL)turnOn{[self setOn:turnOn animated:NO];}
-(BOOL)getIsOn{return (isOn == 0 ? NO : YES);}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	m_touchedSelf = YES;
	[self setOn:isOn animated:YES];
}
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	[super touchesBegan:touches withEvent:event];
	m_touchedSelf = NO;
	isOn = !isOn;
}
-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	[super touchesEnded:touches withEvent:event];
	if(!m_touchedSelf){[self setOn:isOn animated:YES];[self sendActionsForControlEvents:UIControlEventValueChanged];}
    [[NSNotificationCenter defaultCenter] postNotificationName: OnChangeMessage object:nil];
}

-(void)setLeftText:(NSString *)value{[leftLabel setText:value];}
-(void)setRightText:(NSString *)value{[rightLabel setText:value];}

@end
