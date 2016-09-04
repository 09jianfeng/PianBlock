//
//  GameBeatSong.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameBeatSongBuilder.h"
#import "YYModel.h"
#import "GameMacro.h"
#import "GameMusicPerBeat.h"

@implementation GameBeatSongBuilder{
    NSArray<GameMusicPerBeat *> *_beatsArray;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _beatsArray = [NSArray array];
    }
    return self;
}

// lazy load
- (NSArray<GameMusicPerBeat *> *)getBuildResult{
    
    if (_beatsArray) {
        return _beatsArray;
    }
    
    NSString *filePath = [self getSongFilePath:_music];
    if (!filePath) {
        NSLog(@"<error> song not found %@",_music);
        return [NSArray array];
    }
    
    _beatsArray = [NSArray yy_modelArrayWithClass:[GameMusicPerBeat class] json:[NSData dataWithContentsOfFile:filePath]];
    
    return _beatsArray;
}

- (NSString *)getSongFilePath:(NSString *)songName{
    NSString *mainPath = [[NSBundle mainBundle] bundlePath];
    return  [mainPath stringByAppendingPathComponent:songName];
}

- (GameSongProduct *)getSongProductResult{
    return nil;
}

#pragma mark - YYModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

@end
