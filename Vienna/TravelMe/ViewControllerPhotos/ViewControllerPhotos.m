//
//  ViewControllerPhotos.m
//  TravelMe
//
//  Created by Viktor Bondarev on 31.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerPhotos.h"
#import "ViewControllerGalleryPhoto.h"
#import "RDVTabBarController.h"

@interface ViewControllerPhotos ()<ViewControllerPhotoElementDelegate,RDVTabBarControllerDelegate>
{
    ViewControllerGalleryPhoto * viewControllerGalleryPhoto;

}
@end

@implementation ViewControllerPhotos

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        data = [[NSMutableArray alloc] init];

        dataBase=((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataBase;

        //        NSMutableArray * arrayDataBase = [dataBase select:@"Select Element.name_photo,Element.name,Element.description,Sightseenings.id_sightseening from Element,Sightseenings,SightElements where Element.id == SightElements.id_element and Sightseenings.id_sightseening == SightElements.id_sightseening and Sightseenings.is_visible == 1"];

        NSMutableArray * arrayDataBase = (NSMutableArray*)[dataBase loadDataFromDB:@"SELECT * FROM Photos"];

        for(int i=0;i<[arrayDataBase count];i++)
        {
            name_photo158x158 = [self renameNameFile:[[arrayDataBase objectAtIndex:i] objectForKey:@"photo_name"] pasteString:@"150x150"];
            name_photo640x792 = [self renameNameFile:[[arrayDataBase objectAtIndex:i] objectForKey:@"photo_name"] pasteString:@"640x732"];
            [data addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[arrayDataBase objectAtIndex:i] objectForKey:@"name"],@"name",[[arrayDataBase objectAtIndex:i] objectForKey:@"description"],@"description",name_photo158x158, @"photoSmall",name_photo640x792, @"photoFull", [NSString stringWithFormat:@"%d",i], @"idPhoto",nil]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self rdv_tabBarController] setDelegate:self];

    self.title = @"Фото";
    int size =floorf((appWidth-25)/4);

    int summaryX=5, summaryY=0;
    NSInteger *i=0;
    for(NSMutableDictionary * element in data)
    {
        ViewControllerPhotoElement * controller = [[ViewControllerPhotoElement alloc] initWithNibName:@"ViewControllerPhotoElement" bundle:nil];
        [controller setData:data];
        [controller setIdPhoto:[[element objectForKey:@"idPhoto"] intValue]];
        controller.delegate = self;
        [element setObject:controller forKey:@"controller"];
        [scroll addSubview:controller.view];
        [controller.view setFrame:CGRectMake(summaryX, summaryY, size, size)];
        summaryX+=size+5;
        if(summaryX>=appWidth-25){summaryX=5;summaryY+=size+5;}
        i++;
    }

    [scroll setContentSize:CGSizeMake(appWidth, summaryY+size+5)];

    viewControllerGalleryPhoto = [[ViewControllerGalleryPhoto alloc] initWithNibName:@"ViewControllerGalleryPhoto" bundle:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [viewControllerGalleryPhoto setData:data];

}

-(void)setDetailPhotoViewWithPhotoId:(int)idPhoto
{
    [viewControllerGalleryPhoto setTitle:[NSString stringWithFormat:@"Фото %d из %d",idPhoto+1,[data count]]];
    [viewControllerGalleryPhoto setIdPhoto:idPhoto];
    [self.navigationController pushViewController:viewControllerGalleryPhoto animated:YES];
    [viewControllerGalleryPhoto.view setHidden:NO];
}

-(NSString *) renameNameFile:(NSString *) name pasteString:(NSString *) name_string
{
    NSMutableString * icon_name = [[NSMutableString alloc] initWithCapacity:10];
    [icon_name appendFormat:name];

    [icon_name appendFormat:[NSString stringWithFormat:@"_%@",name_string]];
    return icon_name;
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewControllerGalleryPhoto releaseGallery];
}



@end
