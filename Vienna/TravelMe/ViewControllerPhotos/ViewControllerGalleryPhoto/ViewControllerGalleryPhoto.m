//
//  ViewControllerGalleryPhoto.m
//  TravelMe
//
//  Created by Андрей Катюшин on 03.04.12.
//  Copyright (c) 2012 Fess200@yandex.ru. All rights reserved.
//

#import "ViewControllerGalleryPhoto.h"
#import "UIBarButtonItem+CustomBarButtonItem_Category.h"
#import "RDVTabBarController.h"

@interface ViewControllerGalleryPhoto ()

@end

@implementation ViewControllerGalleryPhoto

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        _gallery = [[SoGeViewHorizontalTabGallery alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem*btnBack = [UIBarButtonItem createSquareBarButtonItemWithTitle:@"" withButtonImage:@"back_arrow" withButtonPressedImage:nil target:self action:@selector(btnBackClick:)];

    self.navigationItem.leftBarButtonItem = btnBack;

    [_gallery setFrame:CGRectMake(0, 0, appWidth,self.view.frame.size.height-[[self rdv_tabBarController] tabBar].frame.size.height)];

    [self.view addSubview:_gallery];

    [_gallery setElementWidth:appWidth];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSetCurrentPhoto:) name:@"SetCurrentPhoto" object:nil];
}


-(void) setData:(NSMutableArray *) arrayData
{
    data = arrayData;
    numberPhoto = [data count];

    controllers = [[NSMutableArray alloc] init];

    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{

    for(int i = 0; i < [data count]; i++)
    {
        UIViewController * controller = [[ViewControllerGalleryPhotoElement alloc] initWithNibName:@"ViewControllerGalleryPhotoElement" bundle:nil arrayData:[data objectAtIndex:i]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [_gallery addControllerWihtoutOffset:controller];
        });
    }
    });

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    [_gallery setActiveControllerAtIndex:_idPhoto];

}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

    [super viewWillDisappear:animated];
}

-(void)releaseGallery
{
    [_gallery hide];

}

-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view setHidden:true];

}

-(void)onSetCurrentPhoto:(id) text
{
    _idPhoto = [(NSString *)[text object] integerValue];
    [self setTitle:[NSString stringWithFormat:@"Фото %d из %lu",_idPhoto+1,(unsigned long)[data count]]];
}

-(IBAction)onClickLeftButton:(id)sender
{
    if(_idPhoto == 0) _idPhoto = numberPhoto-1;
    else _idPhoto--;
    [_gallery setActiveControllerAtIndex:_idPhoto];
    [self setTitle:[NSString stringWithFormat:@"Фото %d из %d",_idPhoto+1,[data count]]];
}

-(IBAction)onClickRightButton:(id)sender
{
    if(_idPhoto == numberPhoto-1) _idPhoto = 0;
    else _idPhoto++;
    [_gallery setActiveControllerAtIndex:_idPhoto];
    [self setTitle:[NSString stringWithFormat:@"Фото %d из %d",_idPhoto+1,[data count]]];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
