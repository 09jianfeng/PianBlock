//
//  GameBeatSongDirector.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameBeatSongDirector.h"
#import "GameBeatSongBuilder.h"
#import "YYModel.h"

NSString * const GameSongListFileName = @"Music.json";

@implementation GameBeatSongDirector{
    NSArray<GameBeatSongBuilder *> *_gameMusicList;
}

// lazy load
- (NSArray<GameBeatSongBuilder *> *)gameMusicList{
    if (_gameMusicList) {
        return _gameMusicList;
    }
    
    NSString *musicListFilePath = [self getMusicListPath];
    _gameMusicList = [NSArray yy_modelArrayWithClass:[GameBeatSongBuilder class] json:[NSData dataWithContentsOfFile:musicListFilePath]];
    
    return _gameMusicList;
}

- (NSString *)getMusicListPath{
    NSString *mainPath = [[NSBundle mainBundle] bundlePath];
    
    return  [mainPath stringByAppendingPathComponent:GameSongListFileName];
}

@end
