//
//  GameBeatSong.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongBuilder.h"
#import "YYModel.h"
#import "GameMacro.h"
#import "GameMusicPerBeat.h"
#import "GameSongProduct.h"

@implementation GameSongBuilder{
    NSArray<GameSongProduct *> *_songProductList;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)buildProductWithJsonData:(NSData *)jsonData{
    _songProductList = [NSArray yy_modelArrayWithClass:[GameSongProduct class] json:jsonData];
}

- (NSArray<GameSongProduct *> *)getSongProductList{
    return _songProductList;
}

@end
