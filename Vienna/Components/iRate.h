//
//  iRate.h
//  iRate
//
//  Created by Nick Lockwood on 26/01/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol iRateDelegate

@optional
- (void)iRateCouldNotConnectToAppStore:(NSError *)error;
- (BOOL)iRateShouldShouldPromptForRating;

@end


#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
@interface iRate : NSObject<UIAlertViewDelegate>
#else
@interface iRate : NSObject
#ifdef __i386__
{
	NSUInteger appStoreID;
	NSString *applicationName;
	NSString *applicationVersion;
	NSUInteger usesUntilPrompt;
	NSUInteger eventsUntilPrompt;
	float daysUntilPrompt;
	float remindPeriod;
	NSString *messageTitle;
	NSString *message;
	NSString *cancelButtonLabel;
	NSString *remindButtonLabel;
	NSString *rateButtonLabel;
	NSURL *ratingsURL;
	BOOL disabled;
	BOOL debug;
	id<iRateDelegate> delegate;
}
#endif
#endif

+ (iRate *)sharedInstance;

//app-store id - always set this
@property (nonatomic, assign) NSUInteger appStoreID;

//application name - this is set automatically
@property (nonatomic) NSString *applicationName;

//usage settings - these have sensible defaults
@property (nonatomic, assign) NSUInteger usesUntilPrompt;
@property (nonatomic, assign) NSUInteger eventsUntilPrompt;
@property (nonatomic, assign) float daysUntilPrompt;
@property (nonatomic, assign) float remindPeriod;

//message text, you may wish to customise these, e.g. for localisation
@property (nonatomic) NSString *messageTitle;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *cancelButtonLabel;
@property (nonatomic) NSString *remindButtonLabel;
@property (nonatomic) NSString *rateButtonLabel;

//debugging and disabling
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, assign) BOOL debug;

//advanced properties for implementing custom behaviour
@property (nonatomic) NSURL *ratingsURL;
@property (nonatomic) NSDate *firstUsed;
@property (nonatomic) NSDate *lastReminded;
@property (nonatomic, assign) NSUInteger usesCount;
@property (nonatomic, assign) NSUInteger eventCount;
@property (nonatomic, assign) BOOL declinedThisVersion;
@property (nonatomic, assign) BOOL ratedThisVersion;
@property (nonatomic, unsafe_unretained) id<iRateDelegate> delegate;

//manually control behaviour
- (BOOL)shouldPromptForRating;
- (void)promptForRating;
- (void)promptIfNetworkAvailable;
- (void)openRatingsPageInAppStore;
- (void)logEvent:(BOOL)deferPrompt;

@end
