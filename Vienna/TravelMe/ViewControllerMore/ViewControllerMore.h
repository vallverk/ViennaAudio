//
//  ViewControllerMore.h
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerUserfulInformation.h"
#import "ViewControllerUniversalList.h"
#import "ViewControllerAboutUs.h"
#import "ViewControllerMaps.h"

@interface ViewControllerMore : UIViewController<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView * tableController;
    NSMutableArray * elements;
}

@end
