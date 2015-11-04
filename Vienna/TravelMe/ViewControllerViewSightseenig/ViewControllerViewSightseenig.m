//
//  ViewControllerViewSightseenig.m
//  TravelMe
//
//  Created by Viktor Bondarev on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerViewSightseenig.h"

@interface ViewControllerViewSightseenig ()

@end

@implementation ViewControllerViewSightseenig

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrayData:(NSMutableArray *) arrayData arrayRouteData:(NSMutableArray *) arrayRouteData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        arrayPhotoData = [[NSMutableArray alloc] init];
        arrayPlayData = [[NSMutableArray alloc] init];
        if(!arrayRouteData)
        {
            for(int i=0;i<[arrayData count];i++)
            {
                [arrayPlayData addObject:[[arrayData objectAtIndex:i] objectForKey:@"soundtrack"]];
                [arrayPhotoData addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[arrayData objectAtIndex:i] objectForKey:@"soundtrack"],@"soundtrack", [[arrayData objectAtIndex:i] objectForKey:@"description"],@"description",[[arrayData objectAtIndex:i] objectForKey:@"name"],@"name",[[arrayData objectAtIndex:i] objectForKey:@"name_photo"],@"name_photo",nil]];
            }
        }
        else 
        {
            for(int i=0;i<[arrayRouteData count];i++)
            {
                NSMutableArray * arrayTemp = [arrayRouteData objectAtIndex:i];
                for(int j=0;j<[arrayTemp count];j++)
                {
                    [arrayPlayData addObject:[[arrayTemp objectAtIndex:j] objectForKey:@"soundtrack"]];
                    [arrayPhotoData addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[arrayTemp objectAtIndex:j] objectForKey:@"soundtrack"],@"soundtrack", [[arrayTemp objectAtIndex:j] objectForKey:@"description"],@"description",[[arrayTemp objectAtIndex:j] objectForKey:@"name"],@"name",[[arrayTemp objectAtIndex:j] objectForKey:@"name_photo"],@"name_photo",nil]];
                }
            }
        }
//        [player setAVAudioPlayerDelegate:self];
//        [player cacheWithFiles:arrayPlayData];
        isBuy = YES;
        firsPlay = YES;
        // Custom initialization
    }
    return self;
}

-(void)setPurchasingStatus:(BOOL)purchasingFlag{
    isBuy = purchasingFlag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [player setAVAudioPlayerDelegate:self];
    
//    sizeAll = 0;
//    
//    for(int i=0;i<[player.audioDuration count];i++)
//    {
//        sizeAll += [[player.audioDuration objectAtIndex:i] doubleValue];
//    }
    
//    nowPlayingindex = 0;
//    if(isBuy)
//    {
//        [player playFile:[arrayPlayData objectAtIndex:nowPlayingindex] volume:1 loops:0];
//        isPlay = YES;
//    }
    
//    dragSlider = NO;


    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, appWidth, appHeight-200)];
    
    [gallery setTabsBackgroundImage:nil WithSize:CGSizeMake(appWidth, 20)];
    [gallery setTabsImage:[UIImage imageNamed:@"galleryTab"] WithActiveTabImage:[UIImage imageNamed:@"galleryTabActive"]];
    [gallery setElementWidth:appWidth];
    
    for(NSMutableDictionary * element in arrayPhotoData)
    {
        UIViewController * controller = [[ViewControllerViewSightseenigElement alloc] initWithNibName:@"ViewControllerViewSightseenigElement" bundle:nil arrayData:element];
        [gallery addControllerWihtoutOffset:controller];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fastSpeedPlay:) name:@"SetCurrentPlaybackTime" object:nil];
//    timerUpdateSlider = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
      [player pausePlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
}

// метод инициализирует объект аудиоплеера при первой попытке запустить его в данном вью-контроллере
-(void)setAudioPlayer
{
    nowPlayingindex = 0;
    dragSlider = NO;
    player = [SoundPlayer sharedPlayer]; //[[SoundPlayer alloc] init];
    [player setAVAudioPlayerDelegate:self];
    [player cacheWithFiles:arrayPlayData];
    
    sizeAll = 0;
    
    for(int i=0;i<[player.audioDuration count];i++)
    {
        sizeAll += [[player.audioDuration objectAtIndex:i] doubleValue];
    }
    
    if(isBuy)
    {
        [player playFile:[arrayPlayData objectAtIndex:nowPlayingindex] volume:1 loops:0];
        isPlay = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fastSpeedPlay:) name:@"SetCurrentPlaybackTime" object:nil];
    timerUpdateSlider = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
}


-(void)updateSlider
{
    if(!isPlay) return;
    if(!dragSlider && ![gallery getIsTouchStart])
    {
        if([arrayPlayData count] == 0) NSLog(@"arrayPlayData is empty");
        if(sliderAudio.value>0.999) // ветка окончания воспроизвденеия 
        {
            sliderAudio.value = 1;
            isPlay = YES;
            [self onClickPlayButton:buttonPlay];
            // возвращение состояния плеера в начальное
            [buttonPlay setBackgroundImage:[UIImage imageNamed:@"imageButtonPlay"] forState:UIControlStateNormal];  // отображение кнопки для останволенного плеера
            isPlay = NO;                                                                                            // устновка флага в положение "аудио не проигрывается"
            [player pausePlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];                                     // остановка самого плеера
            nowPlayingindex = 0;                                                                                    // установка текущего проигрываемого элемента на начальный (несколько проигрываемых элементов есть только в маршрутах)
            [sliderAudio setValue:0.0];                                                                             // утановка слайдера в начало
            [player setPlayBackTime:[arrayPlayData objectAtIndex:nowPlayingindex] playBackTime:0];                  // установка маркера воспроизведения в плеере в начальный момент времени
            [gallery setActiveControllerAtIndex:nowPlayingindex];                                                   // утановка галереи на начальный проигрываемый элемент (несколько проигрываемых элементов есть только в маршрутах)
        }
        else 
        {
            double sliderValue = 0;
            for(int i=0;i<nowPlayingindex;i++)
            {
                sliderValue += [[player.audioDuration objectAtIndex:i] doubleValue]/sizeAll;
            }
            
            double valueFinish = sliderValue + [[player.audioDuration objectAtIndex:nowPlayingindex] doubleValue]/sizeAll;
            
            sliderValue += ([player getPlayBackTime:[arrayPlayData objectAtIndex:nowPlayingindex]]/[[player.audioDuration objectAtIndex:nowPlayingindex] doubleValue])*([[player.audioDuration objectAtIndex:nowPlayingindex] doubleValue]/sizeAll);
            
            [sliderAudio setValue:sliderValue];
            
            if(sliderValue >= valueFinish-0.001 && nowPlayingindex < ([arrayPlayData count]-1))
            {
                [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
                nowPlayingindex++;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPin" object:[NSString stringWithFormat:@"%d",nowPlayingindex]];
                [gallery setActiveControllerAtIndex:nowPlayingindex];
                if(isPlay)
                {
                    [player playFile:[arrayPlayData objectAtIndex:nowPlayingindex] volume:1 loops:0];
                }
                
            }
        }
        
        //NSLog(@"%f",sliderAudio.value);
    }
}

-(IBAction)dragSlider:(id)sender
{
    int sliderValue = sliderAudio.value*100;
    if(sliderValue%2==0)
    {
        dragSlider = YES;
        
        double selectDuration = 0;
        double duration = 0;
        int nowPlay = 0;
        
        for(int i=0;i<[player.audioDuration count];i++)
        {
//            NSLog(@"slidervalue = %f duration = %f durationNow = %f sizeAll = %f nowplayinIndex = %d",sliderAudio.value,duration,[[player.audioDuration objectAtIndex:nowPlayingindex] doubleValue],sizeAll, nowPlayingindex);
            selectDuration = (sliderAudio.value - duration)/([[player.audioDuration objectAtIndex:nowPlayingindex] doubleValue]/sizeAll); 
            if(nowPlayingindex != i)
            {
                [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
            }
            
            nowPlay = i;
            
            duration += [[player.audioDuration objectAtIndex:i] doubleValue]/sizeAll; 
            
            if(duration > sliderAudio.value)
                break;
        }
        
        if(nowPlayingindex != nowPlay)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPin" object:[NSString stringWithFormat:@"%d",nowPlay]];
        
        nowPlayingindex = nowPlay;
        
        if(isPlay)
        {
            [player playFile:[arrayPlayData objectAtIndex:nowPlayingindex] volume:1 loops:0];
        }
        
//        NSLog(@"now %d playbackTime %f", nowPlayingindex, selectDuration);
        [player setPlayBackTime:[arrayPlayData objectAtIndex:nowPlayingindex] playBackTime:selectDuration];
        [gallery setActiveControllerAtIndex:nowPlayingindex];
        
    }
}

-(IBAction)endDragSlider:(id)sender
{
    dragSlider = NO;
}

-(IBAction)onClickPlayButton:(id)sender
{
//    SocialNetworks * sn = [[SocialNetworks alloc] initWithDelegate:self];
//    [sn postMessage:@"TestMessage" ToSocialNetwork:SNvkontakte];
    //[sn postMessage:@"Test Message" ToSocialNetwork:SNfacebook];
    
    if(firsPlay){
        [self setAudioPlayer];
        firsPlay = NO;
        [buttonPlay setBackgroundImage:[UIImage imageNamed:@"imageButtonStop"] forState:UIControlStateNormal];
        return;
    }
    
    if(isPlay)
    {
        [buttonPlay setBackgroundImage:[UIImage imageNamed:@"imageButtonPlay"] forState:UIControlStateNormal];
        isPlay = NO;
        [player pausePlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
    }else{
        [buttonPlay setBackgroundImage:[UIImage imageNamed:@"imageButtonStop"] forState:UIControlStateNormal];
        isPlay = YES;
        [player resumePlaing:[arrayPlayData objectAtIndex:nowPlayingindex] withVolume:1];
    }
}

-(void)fastSpeedPlay:(id) text
{
    if(!dragSlider && [gallery getIsTouchStart])
    {
        int offset = [(NSString *)[text object] integerValue];

        if(offset>=0 && offset<=([arrayPlayData count]-1)*appWidth)
        {
            int number_play = offset/appWidth;
            
            [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
            if(nowPlayingindex != number_play)
            {
                nowPlayingindex = number_play;
                //NSLog(@"%@",[NSString stringWithFormat:@"%d",nowPlayingindex]);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPin" object:[NSString stringWithFormat:@"%d",nowPlayingindex]];
            }
        
            if(isPlay)
                [player playFile:[arrayPlayData objectAtIndex:number_play] volume:1 loops:0];
            
        }
        else if (offset<0)
        {
            [sliderAudio setValue:0];
            [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
            nowPlayingindex = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPin" object:[NSString stringWithFormat:@"%d",nowPlayingindex]];
            if(isPlay)
            {
                [player playFile:[arrayPlayData objectAtIndex:0] volume:1 loops:0];
            }
        }
        else if (offset > ([arrayPlayData count]-1)*appWidth)
        {
            
            [sliderAudio setValue:(1-[[player.audioDuration objectAtIndex:([arrayPlayData count]-1)] doubleValue]/sizeAll)];
            [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
            nowPlayingindex = [arrayPlayData count]-1;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPin" object:[NSString stringWithFormat:@"%d",nowPlayingindex]];
            if(isPlay)
            {
                [player playFile:[arrayPlayData objectAtIndex:[arrayPlayData count]-1] volume:1 loops:0];
            }
        }
    }
}



-(void)selectPin:(int) selectItem
{
    [player stopPlaing:[arrayPlayData objectAtIndex:nowPlayingindex]];
    nowPlayingindex = selectItem;
    [gallery setActiveControllerAtIndex:nowPlayingindex];
    [player setPlayBackTime:[arrayPlayData objectAtIndex:nowPlayingindex] playBackTime:0];
    
    if(isPlay)
    {
        [player playFile:[arrayPlayData objectAtIndex:nowPlayingindex] volume:1 loops:0];
    }
}

-(int)getSelectPin
{
    return nowPlayingindex;
}



-(void) dealloc
{
    player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewDidUnload
{
    
}

#pragma mark AVAudioPlayerDelegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"audioPlayerDecodeErrorDidOccur");
}

/* audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. The player will have been paused. */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"audioPlayerBeginInterruption");
}

/* audioPlayerEndInterruption:withFlags: is called when the audio session interruption has ended and this player had been interrupted while playing. */
/* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_AVAILABLE_IOS(4_0){
    NSLog(@"audioPlayerEndInterruption");
}

/* audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
    NSLog(@"audioPlayerEndInterruption");
}

@end
