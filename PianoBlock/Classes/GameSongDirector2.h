//
//  GameSongDirector2.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongAbstractFactory.h"

@interface GameSongDirector2 : NSObject <AFSongDirectorDelegate>

- (void)gameMusicList:(void (^)(NSArray<id<AFSongProductDelegate>> *))completeBlock;

@end
