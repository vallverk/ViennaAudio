//
//  ViewControllerUserfulInformation.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

//#import "ViewControllerMuseumList.h"
//#import "ViewControllerRestaurentList.h"
#import "ViewControllerUsefulPhonesList.h"
#import "ViewControllerUniversalList.h"
//#import "ViewControllerShopsList.h"

@interface ViewControllerUserfulInformation : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView * tableController;
    NSMutableArray * elements;
}

@end
