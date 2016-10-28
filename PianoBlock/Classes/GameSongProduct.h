//
//  GameSongProduct.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameMusicPerBeat;
@interface GameSongProduct : NSObject

- (instancetype)initWithGameSong:(NSArray<GameMusicPerBeat *> *)beatsArray NS_DESIGNATED_INITIALIZER;

- (void)playNextBeat;

- (void)cacheAudio;

- (void)playWholSongWithBeats:(int)timeInterval;

@end
