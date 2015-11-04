//
//  MKStoreManager.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//  mugunthkumar.com
//

#import "MKStoreManager.h"


@implementation MKStoreManager

@synthesize purchasableObjects;
@synthesize storeObserver;
@synthesize delegate;

// all your features should be managed one and only by StoreManager
static NSString *featureAId = @"ru.travelme.rome.rus.HistoricalTour";
static NSString *featureBId = @"ru.travelme.rome.rus.SquaresTour";

BOOL featureAPurchased;
BOOL featureBPurchased;

static MKStoreManager* _sharedStoreManager; // self

+ (BOOL) featureAPurchased {
	
	return featureAPurchased;
}

+ (BOOL) featureBPurchased {
	
	return featureBPurchased;
}

+ (MKStoreManager*)sharedManager
{
	@synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            _sharedStoreManager = [[MKStoreManager alloc] init]; 
			_sharedStoreManager.purchasableObjects = [[NSMutableArray alloc] init];			
			[_sharedStoreManager requestProductData];
			
			[MKStoreManager loadPurchases];
			_sharedStoreManager.storeObserver = [[MKStoreObserver alloc] init];
			[[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedStoreManager.storeObserver];
        }
    }
    return _sharedStoreManager;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone

{	
    @synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            _sharedStoreManager = [super allocWithZone:zone];			
            return _sharedStoreManager;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}


- (void) requestProductData
{
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObjects: featureAId, featureBId, nil]]; // add any other product here
	request.delegate = self;
	[request start];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	[purchasableObjects addObjectsFromArray:response.products];
	// populate your UI Controls here
	/*for(int i=0;i<[purchasableObjects count];i++)
	{
		
		SKProduct *product = [purchasableObjects objectAtIndex:i];
		NSLog(@"Feature: %@, Cost: %f, ID: %@",[product localizedTitle], [[product price] doubleValue], [product productIdentifier]);
	}*/
}

- (void) buyFeatureA
{
	[self buyFeature:featureAId];
}

- (void) buyFeature:(NSString*) featureId
{
	if ([SKPaymentQueue canMakePayments])
	{
		SKPayment *payment = [SKPayment paymentWithProductIdentifier:featureId];
		[[SKPaymentQueue defaultQueue] addPayment:payment];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TravelMe" message:@"Вам необходимо авторезироваться для покупки AppStore" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
}

- (void) buyFeatureB
{
	[self buyFeature:featureBId];
}

-(void)paymentCanceled
{
	if([delegate respondsToSelector:@selector(failed)])
		[delegate failed];
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Невозможно завершить Вашу покупку" message:nil
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	if([delegate respondsToSelector:@selector(failed)])
		[delegate failed];
	
	NSString *messageToBeShown = [NSString stringWithFormat:@"Причина: %@, Вы можете попробовать: %@", [transaction.error localizedFailureReason], [transaction.error localizedRecoverySuggestion]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Невозможно завершить Вашу покупку" message:messageToBeShown
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

-(void) provideContent: (NSString*) productIdentifier
{
	if([productIdentifier isEqualToString:featureAId])
	{
		featureAPurchased = YES;
		if([delegate respondsToSelector:@selector(productAPurchased)])
			[delegate productAPurchased];
	}

	if([productIdentifier isEqualToString:featureBId])
	{
		featureBPurchased = YES;
		if([delegate respondsToSelector:@selector(productBPurchased)])
			[delegate productBPurchased];
	}
	
	[MKStoreManager updatePurchases];
}


+(void) loadPurchases 
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];	
	featureAPurchased = [userDefaults boolForKey:featureAId]; 
	featureBPurchased = [userDefaults boolForKey:featureBId]; 	
}


+(void) updatePurchases
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:featureAPurchased forKey:featureAId];
	[userDefaults setBool:featureBPurchased forKey:featureBId];
}
@end
