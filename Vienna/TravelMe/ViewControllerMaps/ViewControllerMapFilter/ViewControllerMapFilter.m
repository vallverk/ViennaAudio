//
//  ViewControllerMapFilter.m
//  TravelMe
//
//  Created by Viktor Bondarev on 14.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerMapFilter.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"

@interface ViewControllerMapFilter ()

@end

@implementation ViewControllerMapFilter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableArray *) arrayData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        
        arrayFilterData = arrayData;
        
    }
    return self;
}

- (IBAction)onShopsTracking:(id)sender {
    shopFilterFlag = !shopFilterFlag;
    if(shopFilterFlag) [shopFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    else [shopFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];

}

- (IBAction)onMuseumsTracking:(id)sender {
    museumsFilterFlag = !museumsFilterFlag;
    if(museumsFilterFlag) [museumsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    else [museumsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];

}

- (IBAction)onRestrauntsTracking:(id)sender {
    restrauntFilterFlag = !restrauntFilterFlag;
    if(restrauntFilterFlag) [restrauntFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    else [restrauntFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];

}

- (IBAction)onExcursionsTracking:(id)sender {
    excursionsFilterFlag = !excursionsFilterFlag;
    if(excursionsFilterFlag) [excursionsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    else [excursionsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
}

- (IBAction)onBarsTracking:(id)sender {
    barsFilterFlag = !barsFilterFlag;
    if(barsFilterFlag) [barsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    else [barsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@""] && range.location == 0)
    {
        [labelPlaceHolder setHidden:NO];
    }
    else
    {
        [labelPlaceHolder setHidden:YES];
    }
     return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setFilter];

    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for(int i=0;i<[arrayFilterData count];i++)
    {
        switch (i) {
            case 0:
                if([[arrayFilterData objectAtIndex:i] isEqualToString:@"0"])
                {
                    [switchMuseum setOn:NO animated:NO];
                    museumsFilterFlag = NO;
                    [museumsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
                }else{
                    museumsFilterFlag = YES;
                    [museumsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
                }
                break;
            case 1:
                if([[arrayFilterData objectAtIndex:i] isEqualToString:@"0"])
                {
                    [switchRestoraunt setOn:NO animated:NO];
                    restrauntFilterFlag = NO;
                    [restrauntFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
                }else{
                    restrauntFilterFlag = YES;
                    [restrauntFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
                }
                break;
            case 2:
                if([[arrayFilterData objectAtIndex:i] isEqualToString:@"0"])
                {
                    [switchShop setOn:NO animated:NO];
                    shopFilterFlag = NO;
                    [shopFilterButton  setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
                }else{
                    shopFilterFlag = YES;
                    [shopFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
                }
                break;
            case 4:
                if([[arrayFilterData objectAtIndex:i] isEqualToString:@"0"])
                {
                    [switchSightseening setOn:NO animated:NO];
                    excursionsFilterFlag = NO;
                    [excursionsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
                }else{
                    excursionsFilterFlag = YES;
                    [excursionsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
                }
                break;
            case 5:
                if([[arrayFilterData objectAtIndex:i] isEqualToString:@"0"])
                {
                    [switchSightseeningNotBuy setOn:NO animated:NO];
                    barsFilterFlag = NO;
                    [barsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye_notactive"] forState:UIControlStateNormal];
                }else{
                    barsFilterFlag = YES;
                    [barsFilterButton setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
                }
                break;  
            case 6:
                if(![[arrayFilterData objectAtIndex:6] isEqualToString:@""])
                    [labelPlaceHolder setHidden:YES];
                [fieldSearch setText:[arrayFilterData objectAtIndex:6]];
                break;
                
            default:
                break;
        }
    }

    self.title = @"Фильтрация и поиск";
    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([arrayFilterData count]==6)
    {
        fieldSearch.text = [arrayFilterData objectAtIndex:5];
        [labelPlaceHolder setHidden:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setFilter];
}
-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    shopFilterButton = nil;
    museumsFilterButton = nil;
    restrauntFilterButton = nil;
    excursionsFilterButton = nil;
    barsFilterButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)setFilter
{
    [arrayFilterData removeAllObjects];
    
    [arrayFilterData addObject:museumsFilterFlag?@"1":@"0"];
    [arrayFilterData addObject:restrauntFilterFlag?@"1":@"0"];
    [arrayFilterData addObject:shopFilterFlag?@"1":@"0"];
    [arrayFilterData addObject:barsFilterFlag?@"1":@"0"];
    [arrayFilterData addObject:excursionsFilterFlag?@"1":@"0"];

    [arrayFilterData addObject:[fieldSearch text]];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"makeFilterForMap" object:arrayFilterData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
