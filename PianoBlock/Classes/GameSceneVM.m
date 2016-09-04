//
//  ViewControllerVM.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneVM.h"
#import "GameSongProduct.h"

@implementation GameSceneVM{
    GameSongProduct *_song;
}

- (instancetype)initWithSong:(GameSongProduct *)song{
    self = [super init];
    if (self) {
        _song = song;
    }
    return self;
}

- (instancetype)init{
    return [self initWithSong:nil];
}

- (void)playSongNextBeat{
    [_song playNextBeat];
}

@end
