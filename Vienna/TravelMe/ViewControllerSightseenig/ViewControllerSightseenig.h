//
//  ViewControllerSightseenig.h
//  TravelMe
//
//  Created by Viktor Bondarev on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoGeViewHorizontalTabGallery.h"
#import "ViewControllerSightseenigElement.h"
#import "DBManager.h"
#import "MKStoreManager.h"
#import "ViewControllerViewRoute.h"

@interface ViewControllerSightseenig : UIViewController<MKStoreKitDelegate, ViewControllerSightseenigElementDelegate>
{
    IBOutlet SoGeViewHorizontalTabGallery * gallery;
    DBManager * dataBase;

    NSMutableArray * arrayDataBase;
}

- (void)StartBuying:(id) text;
- (void)StartSightseening:(id) text;

@end
