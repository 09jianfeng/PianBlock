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
    NSMutableArray *_musicDataArray;
    NSInteger _beatIndex;
    AVAudioPlayer *_audioPlayer;
    dispatch_queue_t _audioQueue;
}

- (instancetype)initWithGameSong:(NSArray<GameMusicPerBeat *> *)beatsArray{
    self = [super init];
    if (self) {
        _beatsForSong = beatsArray;
        _beatIndex = 0;
        _audioQueue = dispatch_queue_create([@"audioqueue" UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)init{
    self = [self initWithGameSong:nil];
    return self;
}

- (void)playNextBeat{
    dispatch_async(_audioQueue, ^{
        GameMusicPerBeat *beat = _beatsForSong[_beatIndex];
        _beatIndex = (_beatIndex + 1) % _beatsForSong.count;
        
        NSData *musicData = nil;
        if (_musicDataArray) {
            musicData = _musicDataArray[_beatIndex];
        }else{
            NSString *filePath = [self getBeatFilePath:beat.Tone];
            musicData = [NSData dataWithContentsOfFile:filePath];
        }
        
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:musicData error:&error];
        if (error) {
            NSLog(@"<error> %@",error);
            return;
        }
        
        [_audioPlayer prepareToPlay];
        [_audioPlayer play];
    });
}

- (void)cacheAudio{
    dispatch_async(_audioQueue, ^{
        if (_musicDataArray) {
            return ;
        }
        
        _musicDataArray = [[NSMutableArray alloc] initWithCapacity:_beatsForSong.count];
        for (GameMusicPerBeat *beat in _beatsForSong) {
            NSString *filePath = [self getBeatFilePath:beat.Tone];
            NSData *musicData = [NSData dataWithContentsOfFile:filePath];
            [_musicDataArray addObject:musicData];
        }
    });
}

- (void)playWholSongWithBeats:(int)timeInterval{
    
}

- (NSString *)getBeatFilePath:(NSString *)beatName{
    NSString *beatPath = [[NSBundle mainBundle] resourcePath];
    beatPath = [beatPath stringByAppendingFormat:@"/resource1/sounds/Piano_mp3/%@.mp3",beatName];
    return beatPath;
}

@end
