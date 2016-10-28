//
//  GameSongDirector.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongAbstractFactory.h"

@class GameSongProduct;
@interface GameSongDirector : NSObject <AFSongDirectorDelegate>

- (NSArray<id<AFSongProductDelegate>> *)gameMusicList;

@end
