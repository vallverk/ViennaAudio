//
//  AppDelegate.m
//  TravelMe
//
//  Created by Viktor Bondarev on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()
@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    [Fabric with:@[[Crashlytics class]]];

   // [[Crashlytics sharedInstance] setDebugMode:YES];

    self.dataBase = [[DBManager alloc] initWithDatabaseFilename:@"TravelMe.db"];

    NSFileManager * FM = [[NSFileManager alloc] init];
    NSString * filesHashe = @"";

    for(NSMutableDictionary * element in [self.dataBase loadDataFromDB:@"SELECT * FROM Element"])
    {
        NSString * file = [[NSBundle mainBundle] pathForResource:[[element objectForKey:@"soundtrack"] stringByReplacingOccurrencesOfString:@".mp3" withString:@""] ofType:@"mp3"];
        filesHashe = [filesHashe stringByAppendingFormat:@"%@_%@ :: ",[element objectForKey:@"soundtrack"], [[FM attributesOfItemAtPath:file error:nil] objectForKey:@"NSFileSize"]];
    }

    [self.window setBackgroundColor:[UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1.0]];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self customizeInterface];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.window makeKeyAndVisible];

    UIAlertView*alertView = [[UIAlertView alloc] initWithTitle:@"ВСЕГО 30 ЕВРО" message:@"Закажите такси из/в Венский аэропорт! Это удобно, надежно и дешевле обычного такси!" delegate:self cancelButtonTitle:@"Заказать" otherButtonTitles:@"Нет",nil];

    [alertView show];

    return YES;
}

-(void) setupViewControllers
{
    UIViewController *firstViewController = [[ViewControllerSightseenig alloc] initWithNibName:@"ViewControllerSightseenig" bundle:nil];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];

    UIViewController *secondViewController = [[ViewControllerRoutes alloc] initWithNibName:@"ViewControllerRoutes" bundle:nil];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];

    UIViewController *thirdViewController = [[ViewControllerPhotos alloc] initWithNibName:@"ViewControllerPhotos" bundle:nil];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];

    UIViewController *fouthViewController = [[ViewControllerAboutUs alloc] initWithNibName:@"ViewControllerAboutUs" bundle:nil];
    UIViewController *fouthNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fouthViewController];

    UIViewController *fithViewController = [[ViewControllerMore alloc] initWithNibName:@"ViewControllerMore" bundle:nil];
    UIViewController *fithNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:fithViewController];

    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,fouthNavigationController,fithNavigationController]];

    self.viewController = tabBarController;

    [self customizeTabBarForController:tabBarController];

}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {

    // [tabBarController.tabBar.backgroundView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBarBackground"]]];
    UIImage *finishedImage = [UIImage imageNamed:@"tabBarSelected"];
    NSArray *tabBarItemImages = @[@"excursion", @"TRANSFER", @"Photo",@"About_us",@"MORE"];
    NSArray*arrTitles =@[@"Экскурсии", @"Такси", @"Фото",@"О нас",@"Еще"];

    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:nil];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_ACTIVE",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_NONACTIVE",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[arrTitles objectAtIndex:index]];
        [item setTintColor:[UIColor whiteColor]];

        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];

    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;

    backgroundImage = [UIImage imageNamed:@"navigationControllerBackground"];

    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                       NSForegroundColorAttributeName: [UIColor whiteColor],
                       };

    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];

    UIView *addStatusBar = [[UIView alloc] init];
    addStatusBar.frame = CGRectMake(0, 0, 3000, 20);
    addStatusBar.backgroundColor = [UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1];
    //change this to match your navigation bar

    [self.window.rootViewController.view addSubview:addStatusBar];
}

-(void)onClickSightseeng:(NSString *) idSightseening
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetActiveGalleryIndex" object:idSightseening];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"ShowTabBar" object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
            if(installed)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"skype:+436607555555?call"]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://austriaday.com"]];
            }
        }
        else
        {
            BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
            if(installed)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:+436607555555"]]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://austriaday.com"]];
            }
        }


    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
