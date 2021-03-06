//
//  SongAbstractFactory.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFSongProductDelegate <NSObject>

@required
- (void)playNextBeat;
- (void)cacheAudio;
- (void)playWholSongWithBeats:(int)timeInterval;

@end

@protocol AFSongDirectorDelegate <NSObject>

@required
- (void)gameMusicList:(void (^)(NSArray<id<AFSongProductDelegate>> *list))completeBlock;
@end
