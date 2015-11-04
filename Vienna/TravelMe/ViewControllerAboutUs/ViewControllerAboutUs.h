//
//  ViewControllerAboutUs.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>
@interface ViewControllerAboutUs : UIViewController<MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController * picker;
    IBOutlet UILabel*text;
}

//social netorks buttons clicks handlers
-(IBAction)onVkontakteClick:(id)sender;
-(IBAction)onFacebookClick:(id)sender;
-(IBAction)onTwitterClick:(id)sender;
-(IBAction)onYoutubeClick:(id)sender;

- (IBAction)sendEmail:(id)sender;

@end