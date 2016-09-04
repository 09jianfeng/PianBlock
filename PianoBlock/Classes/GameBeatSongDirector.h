//
//  GameBeatSongDirector.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameBeatSongBuilder;
@interface GameBeatSongDirector : NSObject

- (NSArray<GameBeatSongBuilder *> *)gameMusicList;

@end
