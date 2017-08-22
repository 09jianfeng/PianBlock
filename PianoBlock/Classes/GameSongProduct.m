//
//  GameSongProduct.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongProduct.h"
#import "GameMusicPerBeat.h"
#import "YYModel.h"
#import <AVFoundation/AVFoundation.h>

@interface GameSongProduct()
@property(nonatomic, strong) NSArray<GameMusicPerBeat *> *beatsForSong;
@end

@implementation GameSongProduct{
    NSMutableArray *_musicDataArray;
    NSInteger _beatIndex;
    AVAudioPlayer *_audioPlayer;
    dispatch_queue_t _audioQueue;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _beatIndex = 0;
        _audioQueue = dispatch_queue_create([@"audioqueue" UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (NSArray<GameMusicPerBeat *> *)beatsForSong{
    if (_beatsForSong) {
        return _beatsForSong;
    }
    
    NSString *mainPath = [[NSBundle mainBundle] resourcePath];
    NSString *songPath = [mainPath stringByAppendingFormat:@"/resource1/data/%@",_music];
    
    _beatsForSong = [NSArray yy_modelArrayWithClass:[GameMusicPerBeat class] json:[NSData dataWithContentsOfFile:songPath]];
    
    return _beatsForSong;
}

- (void)playNextBeat{
    dispatch_async(_audioQueue, ^{
        GameMusicPerBeat *beat = self.beatsForSong[_beatIndex];
        _beatIndex = (_beatIndex + 1) % self.beatsForSong.count;
        
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
        
        _musicDataArray = [[NSMutableArray alloc] initWithCapacity:self.beatsForSong.count];
        for (GameMusicPerBeat *beat in self.beatsForSong) {
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


#pragma mark - YYModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }


@end
