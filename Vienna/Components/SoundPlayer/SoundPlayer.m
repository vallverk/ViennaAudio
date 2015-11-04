//
//  SoundPlayer.m
//  MySoundPlayer
//
//  Created by Alximik on 15.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

@synthesize audioFiles;
@synthesize audioDuration;

static SoundPlayer * sharedPlayer = NULL;
static NSURL * currentAudiofileUrl = NULL;
static NSString * currentAudiofileName = NULL;
+(NSURL*)currentAudiofileUrl{
    return currentAudiofileUrl;
}
+(NSString*) currentAudiofileName{
    return currentAudiofileName;
}
+ (SoundPlayer *) sharedPlayer {
    if ( !sharedPlayer || sharedPlayer == NULL ) {
        sharedPlayer = [SoundPlayer new];
    }
    return sharedPlayer;
}

+ (void)playSound:(NSString*)soundName {
    SystemSoundID volleyFile;
    NSString *volleyPath = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    CFURLRef volleyURL = (__bridge CFURLRef ) [NSURL fileURLWithPath:volleyPath];
    AudioServicesCreateSystemSoundID (volleyURL, &volleyFile);
    AudioServicesPlaySystemSound(volleyFile);
}

- (void)cacheWithFiles:(NSArray *)sounds {
    // проверка текущего воспроизведения для статического аудиоплеера
    if(self == [SoundPlayer sharedPlayer]){ // даннное разветвление предназначено только для случая использования статического sharedPlayer в качестве аудиоплеера
        BOOL finded = NO;
        for (NSString *fileName in sounds) {
            if([fileName isEqualToString:currentAudiofileName]) finded = YES;
        }
        if(finded) return;
        else currentAudiofileName = [sounds objectAtIndex:0];
    }
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSError *error;
    
    self.audioFiles = [NSMutableDictionary dictionary];
    self.audioDuration = [NSMutableArray array];
    
    for (NSString *fileName in sounds) {
        NSURL *soundURL = [NSURL fileURLWithPath:[mainBundle pathForResource:fileName ofType:nil]];
        AVAudioPlayer *myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL 
                                                                              error:&error];
        myAudioPlayer.delegate = delegate;
        if(self == [SoundPlayer sharedPlayer]){
            // для воспроизведения аудио при свертывнии приложения
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            [[AVAudioSession sharedInstance] setActive: YES error: nil];
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        }
        
        if (myAudioPlayer) {
            [myAudioPlayer prepareToPlay];
            [audioFiles setObject:myAudioPlayer forKey:fileName];
            [audioDuration addObject:[NSString stringWithFormat:@"%f",[myAudioPlayer duration]]]; 
        } else {
            NSLog(@"Error in file(%@): %@\n", fileName, [error localizedDescription]);
        }
    }    
}

- (void)playFile:(NSString*)soundFileName volume:(CGFloat)volume loops:(NSInteger)numberOfLoops {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
    sound.volume = volume;
    sound.numberOfLoops = numberOfLoops;
    sound.currentTime = 0.0f;
    [sound play];
}

-(void) setPlayBackTime:(NSString *) soundFileName playBackTime:(double) timeInterval
{
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
    double time = [sound duration] * timeInterval;
    [sound setCurrentTime:time];
}

- (double)getPlayBackTime:(NSString *) soundFileName
{
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
    return [sound currentTime];
}

- (void)resumePlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
	[sound pause];    
}

- (void)resumePlaing:(NSString*)soundFileName withVolume:(CGFloat)volume {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
    sound.volume = volume;
	[sound play];    
}

- (void)pausePlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
	[sound pause];
}

- (void)stopPlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
	[sound stop];    
}

- (BOOL)isPlaying:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.delegate = delegate;
	return sound.playing;    
}

- (void)setAVAudioPlayerDelegate:(id<AVAudioPlayerDelegate>)_delegate{
    delegate = _delegate;
}

- (void)dealloc {
    [self.audioFiles removeAllObjects];
    [self.audioDuration removeAllObjects];
    
    self.audioDuration = nil;
    self.audioFiles = nil;
}

@end
