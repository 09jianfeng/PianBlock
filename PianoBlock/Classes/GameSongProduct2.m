//
//  GameSongProduct2.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongProduct2.h"

@interface GameSongProduct2()

@end

@implementation GameSongProduct2{
    NSMutableArray *_musicBeatDataAry;
    NSInteger _beatIndex;
    NSInteger _baseBpm;
    NSDictionary *_songJson;
}

- (instancetype)initWithValues:(NSArray *)array{
    self = [super init];
    if (self) {
        if (array) {
            _file = array[1];
            _name = array[2];
            _author = array[3];
            _defaultBeats = array[4];
            _acceleration = array[5];
            _unlockType = array[6];
            _unlockValue = array[7];
            
            NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/resource2/song/%@.json",_file]];
            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            if (fileData) {
                _songJson = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
            }
            
        }
    }
    return self;
}

- (instancetype)init{
    self = [self initWithValues:nil];
    return self;
}

- (void)setFile:(NSString *)file{
    _file = file;
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/resource2/song/%@.json",_file]];
    _songJson = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
}


- (void)playNextBeat{
    
}

- (void)cacheAudio{
    if (!_file) {
        return;
    }
    
}

- (void)playWholSongWithBeats:(int)timeInterval{
    
}

@end
