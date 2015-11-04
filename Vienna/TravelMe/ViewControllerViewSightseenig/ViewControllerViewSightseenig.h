//
//  ViewControllerViewSightseenig.h
//  TravelMe
//
//  Created by Viktor Bondarev on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoGeViewHorizontalTabGallery.h"
#import "ViewControllerViewSightseenigElement.h"
#import "SoundPlayer.h"

@interface ViewControllerViewSightseenig : UIViewController<UINavigationControllerDelegate,AVAudioPlayerDelegate>
{
    IBOutlet SoGeViewHorizontalTabGallery * gallery;
    IBOutlet UIButton * buttonPlay;
    IBOutlet UISlider * sliderAudio;
    
    SoundPlayer * player;
    BOOL isPlay;
    BOOL dragSlider;
    NSMutableArray * arrayPlayData;
    NSMutableArray * arrayPhotoData;
    int nowPlayingindex;
    NSTimer * timerUpdateSlider;
    BOOL isBuy;
    double sizeAll;
    UIAlertView *alert;
;
    
    BOOL firsPlay;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableArray *) arrayData arrayRouteData:(NSMutableArray *) arrayRouteData;

-(IBAction)onClickPlayButton:(id)sender;
-(void)fastSpeedPlay:(id) text;
-(void)updateSlider;
-(IBAction)dragSlider:(id)sender;
-(IBAction)endDragSlider:(id)sender;
-(void)selectPin:(int) selectItem;
-(int)getSelectPin;

-(void)setPurchasingStatus:(BOOL)purchasingFlag;
@end
