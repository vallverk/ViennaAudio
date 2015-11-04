//
//  AppDelegate.h
//  TravelMe
//
//  Created by Viktor Bondarev on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerSightseenig.h"
#import "ViewControllerRoutes.h"
#import "ViewControllerPhotos.h"
#import "ViewControllerMore.h"
#import "iRate.h"
#import "DBManager.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DBManager*dataBase;
@property (strong, nonatomic) UIViewController *viewController;
-(void)onClickSightseeng:(NSString *) idSightseening;

@end
