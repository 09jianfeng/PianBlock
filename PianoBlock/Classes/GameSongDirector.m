//
//  GameSongDirector.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongDirector.h"
#import "GameSongProduct.h"
#import "GameSongBuilder.h"

static NSString * const GameSongListFileName = @"resource1/data/Music.json";

@implementation GameSongDirector{
    NSArray<GameSongProduct *> *_gameMusicList;
}


- (void)gameMusicList:(void (^)(NSArray<id<AFSongProductDelegate>> *list))completeBlock{
    if (_gameMusicList) {
        completeBlock(_gameMusicList);
    }
    
    NSString *musicListFilePath = [self getMusicListPath];
    GameSongBuilder *songBuilder = [[GameSongBuilder alloc] init];
    [songBuilder buildProductWithJsonData:[NSData dataWithContentsOfFile:musicListFilePath]];
    
    _gameMusicList = [songBuilder getSongProductList];
    completeBlock(_gameMusicList);
}

- (NSString *)getMusicListPath{
    NSString *mainPath = [[NSBundle mainBundle] bundlePath];
    
    return  [mainPath stringByAppendingPathComponent:GameSongListFileName];
}

@end
