//
//  ViewControllerPhotos.h
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerPhotoElement.h"
#import "DBManager.h"

@interface ViewControllerPhotos : UIViewController
{
    NSMutableArray * data;
    DBManager * dataBase;
    NSMutableArray*controllers;
    
    NSString * name_photo158x158,*name_photo640x792;

    IBOutlet UIScrollView*scroll;
}

-(NSString *) renameNameFile:(NSString *) name pasteString:(NSString *) name_string;

@end
