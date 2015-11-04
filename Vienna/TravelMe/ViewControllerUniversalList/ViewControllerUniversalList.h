//
//  ViewControllerUniversalList.h
//  TravelMe
//
//  Created by Viktor Bondarev on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerUniversalViewElementList.h"
#import "DBManager.h"
#import "AppDelegate.h"
#import "ViewControllerOtherPrograms.h"

@interface ViewControllerUniversalList : UIViewController<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView * tableController;
    NSMutableArray * elements;
    NSInteger typeElement;
    NSString * typeNumber;
    NSString *typeName;
    DBManager * dataBase;
    ViewControllerUniversalViewElementList * viewControllerUniversalViewElementList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(NSInteger) type;

@end
