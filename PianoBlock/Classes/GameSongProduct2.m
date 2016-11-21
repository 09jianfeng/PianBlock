//
//  GameSongProduct2.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongProduct2.h"

static NSString * const filePath = @"resource2/song/Happy New Year.json";

@interface GameSongProduct2()

@end

@implementation GameSongProduct2{
    NSMutableArray *_musicBeatDataAry;
    NSInteger _beatIndex;
}

- (instancetype)initWithValues:(NSArray *)array{
    self = [super init];
    if (self) {
        if (array) {
            _file = array[0];
            _name = array[1];
            _author = array[2];
            _defaultBeats = array[3];
            _acceleration = array[4];
            _unlockType = array[5];
            _unlockValue = array[6];
        }
    }
    return self;
}

- (instancetype)init{
    self = [self initWithValues:nil];
    return self;
}



- (void)playNextBeat{
    
}

- (void)cacheAudio{
    
}

- (void)playWholSongWithBeats:(int)timeInterval{
    
}

@end
