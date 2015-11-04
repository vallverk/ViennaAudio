//
//  ViewHorizontalTabGallery.m
//  OAK
//
//  Created by Viktor Bondarev on 19.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoGeViewHorizontalTabGallery.h"

@interface SoGeViewHorizontalTabGallery(data)
-(void)validate;
-(void)validateScreens;
-(void)setActiviti:(BOOL)value forButtonAtIndex:(NSInteger)index;
-(IBAction)onButtonClick:(id)sender;
@end

@implementation SoGeViewHorizontalTabGallery

-(void)initData
{
    [self setBackgroundColor:[UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1.0]];
    
    isTouchStart = NO;
    
    controllers = [[NSMutableArray alloc] init];
   // tabsBackgroundImage = [UIImage imageNamed:@"viewHorizontalTabGalleryBackground"];
    tabImage = [UIImage imageNamed:@"viewHorizontalTabGalleryTabBackground"];
    tabActiveImage = [UIImage imageNamed:@"viewHorizontalTabGalleryTabSelected"];
    tabsSize = CGSizeMake(appWidth, 20);

    current = -1;
    buttons = [[NSMutableArray alloc] init];
    elementWidth = appWidth;
    
    viewTabs = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - tabsSize.height, appWidth, tabsSize.height)];
    [viewTabs setBackgroundColor:[UIColor clearColor]];
    [self addSubview:viewTabs];

    imageViewTabsBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, appWidth, tabsSize.height)];
    [imageViewTabsBackground setImage:tabsBackgroundImage];
    [imageViewTabsBackground setBackgroundColor:[UIColor clearColor]];
    [viewTabs addSubview:imageViewTabsBackground];
    [imageViewTabsBackground setCenter:CGPointMake(appWidth/ 2, imageViewTabsBackground.center.y)];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, appWidth, self.frame.size.height-100)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView setBackgroundColor:[UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1.0]];
    [scrollView setDelegate:self];
    [scrollView setBounces:NO];
    [scrollView setPagingEnabled:YES];
    [self addSubview:scrollView];
    [self bringSubviewToFront:viewTabs];

    [scrollView setClipsToBounds:NO];
}
-(id)init
{
    self = [super init];
    if (self){[self initData];}
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){[self initData];[self setFrame:frame];}
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){[self initData];}
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [viewTabs setFrame:CGRectMake(0, self.frame.size.height - tabsSize.height+5, appWidth, tabsSize.height)];
    [imageViewTabsBackground setFrame:CGRectMake(0, 0, appWidth, tabsSize.height)];
    [imageViewTabsBackground setCenter:CGPointMake(appWidth / 2, imageViewTabsBackground.center.y)];
    [scrollView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

-(void)setTabsBackgroundImage:(UIImage *)image WithSize:(CGSize)size
{
    if(!image) return;
    tabsBackgroundImage = image;
    [imageViewTabsBackground setImage:tabsBackgroundImage];
    tabsSize = size;
    
    [viewTabs setFrame:CGRectMake(0, self.frame.size.height, appWidth, tabsSize.height)];
    [imageViewTabsBackground setFrame:CGRectMake(0, 0, appWidth, tabsSize.height)];
    [imageViewTabsBackground setCenter:CGPointMake(appWidth / 2, imageViewTabsBackground.center.y)];
}
-(void)setTabsImage:(UIImage *)image WithActiveTabImage:(UIImage *)imageActive
{
    if(image) tabImage = image;
    if(imageActive) tabActiveImage = imageActive;
    [self validate];
}
-(void)setElementWidth:(NSInteger)width{elementWidth=width;}

-(void)addController:(UIViewController *)controller
{
    if(!controller) return;
    [controllers addObject:controller];

    [self validate];
    /*if([controllers count] >= current && [controllers count] <= current + 2)*/ [scrollView addSubview:controller.view];
//    CGFloat offset = (self.frame.size.width - elementWidth) / 2;
    CGFloat offset = 0;
    [controller.view setFrame:CGRectMake(([controllers count] == 1 ? offset : scrollView.contentSize.width - offset + 1), 0, appWidth, scrollView.frame.size.height)];
    [scrollView setContentSize:CGSizeMake(controller.view.frame.origin.x + controller.view.frame.size.width + offset, scrollView.frame.size.height)];
}

-(void)addControllerWihtoutOffset:(UIViewController *)controller
{
    if(!controller) return;
    [controllers addObject:controller];

    [self validate];
    /*if([controllers count] >= current && [controllers count] <= current + 2)*/ [scrollView addSubview:controller.view];
    [controller.view setFrame:CGRectMake(([controllers count] == 1 ? 0 : scrollView.contentSize.width), 0, elementWidth, scrollView.frame.size.height)];
    [scrollView setContentSize:CGSizeMake(controller.view.frame.origin.x + controller.view.frame.size.width, scrollView.frame.size.height)];
}


-(void)setActiveController:(UIViewController *)controller{}
-(UIViewController *)getActiveController{return (current < 0 ? nil : [controllers objectAtIndex:current]);}
-(UIViewController *)getController:(int) id_controller
{
    return [controllers objectAtIndex:id_controller];
}
-(void)setActiveControllerAtIndex:(NSInteger)index
{
    if(index < 0) index = 0;
    if(index > [controllers count]) index = [controllers count] - 1;
    
    [self setActiviti:NO forButtonAtIndex:current];
    current = index;
    [self setActiviti:YES forButtonAtIndex:current];
    [self validateScreens];
}
-(NSInteger)getIndexActiveController{return current;}

-(BOOL)getIsTouchStart
{
    return isTouchStart;
}

-(void)hide
{
    controllers = nil;
}

-(void)validate
{
    if([controllers count] > [buttons count])
    {
        //добавить кнопку на нижнюю панель и выровнять их
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [button setTag:[buttons count]];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [self setActiviti:NO forButtonAtIndex:[buttons count] - 1];
        [viewTabs addSubview: button];
        
        NSInteger elWidth = 10;
        NSInteger x = (appWidth - ([buttons count] - 1) * elWidth) / 2;
        for(UIButton * element in buttons)
        {
            [element setCenter:CGPointMake(x, viewTabs.frame.size.height / 2)];
            x += elWidth;
        }
    }
    
    if(current == -1)
    {
        //установить экран
        if([controllers count] == 0) return;
        
        current = 0;
        [self setActiviti:YES forButtonAtIndex:current];
    }
    
    //установить остальные экраны
    [self validateScreens];
}
-(void)setActiviti:(BOOL)value forButtonAtIndex:(NSInteger)index
{
    UIImage * image = nil;
    if(value == YES) image = tabActiveImage;
    else image = tabImage;
        
    [[buttons objectAtIndex:index] setImage:image forState:UIControlStateNormal];
    [[buttons objectAtIndex:index] setImage:image forState:UIControlStateHighlighted];
    [[buttons objectAtIndex:index] setImage:image forState:UIControlStateSelected];
}
-(IBAction)onButtonClick:(id)sender
{
//    UIButton * button = (UIButton *)sender;
//    [self setActiveControllerAtIndex:button.tag];
}
-(void)validateScreens{[scrollView setContentOffset:CGPointMake(current * elementWidth, 0) animated:YES];}


-(void)scrollViewDidScroll:(UIScrollView *)scrollViewEl
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    [self performSelector:@selector(EndScrollingAnimation) withObject:nil afterDelay:0.3];
    
    CGFloat elementsOffset = (self.frame.size.width - elementWidth) / 2;
    NSInteger offset = scrollViewEl.contentOffset.x - elementsOffset;
    if(offset > 0 && offset < scrollViewEl.contentSize.width - scrollViewEl.frame.size.width)
    {
        int n = 0;
        if(offset > 90) n = (offset - 90) / elementWidth + 1;
        //NSLog(@"offset %d",offset + 40);
        if(current != n)
        {
            /*if(n > current)
            {
                if(current > 0)
                {
                    [((UIViewController *)[controllers objectAtIndex:current - 1]).view removeFromSuperview];
                    [((UIViewController *)[controllers objectAtIndex:current - 1]) removeFromParentViewController];
                }
                if(n + 1 < [controllers count])[scrollView addSubview:((UIViewController *)[controllers objectAtIndex:n + 1]).view];
            }
            
            if(n < current)
            {
                if(current < [controllers count] - 1)
                {
                    [((UIViewController *)[controllers objectAtIndex:current + 1]).view removeFromSuperview];
                    [((UIViewController *)[controllers objectAtIndex:current + 1]) removeFromParentViewController];
                }
                if(n > 0)[scrollView addSubview:((UIViewController *)[controllers objectAtIndex:n - 1]).view];
            }*/
            
            [self setActiviti:NO forButtonAtIndex:current];
            current = n;
            [self setActiviti:YES forButtonAtIndex:current];
        }
    }
    
    if(offset%10==0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetCurrentPlaybackTime" object:[NSString stringWithFormat:@"%d",offset]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetCurrentPhoto" object:[NSString stringWithFormat:@"%d",current]];

}

-(void)EndScrollingAnimation
{
    CGFloat elementsOffset = (self.frame.size.width - elementWidth) / 2;
    NSInteger offset = scrollView.contentOffset.x - elementsOffset;
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; 
    if(offset%elementWidth == 0)
    {
        //NSLog(@"EndDrag");
        isTouchStart = NO;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isTouchStart = YES;
    //NSLog(@"BeginDrag");
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollViewEl willDecelerate:(BOOL)decelerate{if(decelerate == NO) [self validateScreens];}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollV {}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewEl{[self validateScreens];}

@end
