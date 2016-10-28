//
//  GameSongProduct2.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongAbstractFactory.h"

@interface GameSongProduct2 : NSObject <AFSongProductDelegate>

- (void)playNextBeat;

- (void)cacheAudio;

- (void)playWholSongWithBeats:(int)timeInterval;

@end
