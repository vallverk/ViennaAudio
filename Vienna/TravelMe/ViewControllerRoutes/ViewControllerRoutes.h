//
//  ViewControllerRoutes.h
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoGeViewHorizontalTabGallery.h"
#import "ViewControllerRouteElement.h"
#import "DBManager.h"
#import "AppDelegate.h"

@interface ViewControllerRoutes : UIViewController
{
    IBOutlet SoGeViewHorizontalTabGallery * gallery;
    
    DBManager * dataBase;
}

@end
