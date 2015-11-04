//
//  ViewControllerAboutUs.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerAboutUs.h"

@interface ViewControllerAboutUs ()

@end

@implementation ViewControllerAboutUs

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"О нас";
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        [text setFont:[UIFont systemFontOfSize:16]];
}

#pragma mark NSNotificationMethods
//**********************************************
// NSNotificationMethods
//**********************************************
-(void) onAboutDownloaded: (NSNotification *) notification{
    if(notification){
//        aboutData = [[notification userInfo] objectForKey:@"text"];
//        if([self isViewLoaded]){
//            [internalWebView loadHTMLString: aboutData baseURL:nil];
//        }
    }
}

#pragma mark social netorks buttons clicks handlers
-(IBAction)onVkontakteClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/loveaustria"]];
}
-(IBAction)onFacebookClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/welovewien"]];
}
-(IBAction)onTwitterClick:(id)sender{
    
}
-(IBAction)onYoutubeClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/user/privetaustria"]];
}


#pragma mark MFMailComposeViewControllerDelegate
//**********************************************
//MFMailComposeViewControllerDelegate
//**********************************************
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSString * message;
    switch (result)
	{
		case MFMailComposeResultCancelled:
			message = @"Отправка отменена";
			break;
		case MFMailComposeResultSaved:
			message = @"Сообщение сохранено";
			break;
		case MFMailComposeResultSent:
			message = @"Сообщение отправлено";
			break;
		case MFMailComposeResultFailed:
			message = @"Сообщение не отправлено";
			break;
		default:
			message = @"Сообщение не отправлено";
			break;
	}
    [picker dismissViewControllerAnimated:YES completion:^(void){}];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    picker = nil;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
#pragma mark -
- (IBAction)sendEmail:(id)sender
{
    if([MFMailComposeViewController canSendMail]){
        picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        NSArray *toRecipients = [NSArray arrayWithObjects:@"rasodallas@gmail.com",@"rasodallas@yahoo.com",nil];
        [picker setToRecipients:toRecipients];
        [picker.navigationBar setTintColor:[UIColor whiteColor]];
        [self presentViewController:picker animated:YES completion:^(void){}];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Невозможно отправить сообщение. Не настроена отправка почтовых сообщений." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}
@end
