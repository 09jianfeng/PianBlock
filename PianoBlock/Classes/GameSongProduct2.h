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
@property (nonatomic ,copy) NSString *file;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *author;
@property (nonatomic ,copy) NSString *defaultBeats;
@property (nonatomic ,copy) NSString *acceleration;
@property (nonatomic ,copy) NSString *unlockType;
@property (nonatomic ,copy) NSString *unlockValue;

- (instancetype)initWithValues:(NSArray *)array NS_DESIGNATED_INITIALIZER;

- (void)playNextBeat;

- (void)cacheAudio;

- (void)playWholSongWithBeats:(int)timeInterval;

@end
