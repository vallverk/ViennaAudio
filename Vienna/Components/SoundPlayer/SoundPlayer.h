//
//  SoundPlayer.h
//  MySoundPlayer
//
//  Created by Alximik on 15.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer : NSObject {
    NSMutableDictionary *audioFiles;
    __unsafe_unretained id<AVAudioPlayerDelegate> delegate;
}

@property (nonatomic,retain) NSMutableDictionary *audioFiles;
@property (nonatomic,retain) NSMutableArray *audioDuration;

+(SoundPlayer *)sharedPlayer;
+(NSString*) currentAudiofileName;

+ (void)playSound:(NSString*)soundName;

- (void)cacheWithFiles:(NSArray *)sounds;
- (void)playFile:(NSString*)soundFileName volume:(CGFloat)volume loops:(NSInteger)numberOfLoops;
- (void)resumePlaing:(NSString*)soundFileName;
- (void)resumePlaing:(NSString*)soundFileName withVolume:(CGFloat)volume;
- (void)pausePlaing:(NSString*)soundFileName;
- (void)stopPlaing:(NSString*)soundFileName;
- (BOOL)isPlaying:(NSString*)soundFileName;
- (void)setPlayBackTime:(NSString *) soundFileName playBackTime:(double) timeInterval;
- (double)getPlayBackTime:(NSString *) soundFileName;
- (void)setAVAudioPlayerDelegate:(id<AVAudioPlayerDelegate>)_delegate;
@end
