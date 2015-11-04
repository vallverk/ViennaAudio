//
//  ViewControllerUsefulPhonesList.h
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//


@interface ViewControllerUsefulPhonesList : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView * tableController;
    NSMutableArray * elements;
}

@end
