//
//  GameSongProduct.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongProduct.h"
#import "GameMusicPerBeat.h"
#import <AVFoundation/AVFoundation.h>

@implementation GameSongProduct{
    NSArray<GameMusicPerBeat *> *_beatsForSong;
    NSInteger _beatIndex;
    AVAudioPlayer *_audioPlayer;
}

- (instancetype)initWithGameSong:(NSArray<GameMusicPerBeat *> *)beatsArray{
    self = [super init];
    if (self) {
        _beatsForSong = beatsArray;
        _beatIndex = 0;
    }
    return self;
}

- (instancetype)init{
    self = [self initWithGameSong:nil];
    return self;
}

- (void)playNextBeat{
    GameMusicPerBeat *beat = _beatsForSong[_beatIndex];
    _beatIndex = (_beatIndex + 1) % _beatsForSong.count;
    
    NSString *filePath = [self getBeatFilePath:beat.Tone];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];;
    if (error) {
        NSLog(@"<error> %@",error);
        return;
    }
    
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

- (void)cacheAudio{
    
}

- (NSString *)getBeatFilePath:(NSString *)beatName{
    return [[NSBundle mainBundle] pathForResource:beatName ofType:@"mp3"];
}

@end
