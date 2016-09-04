//
//  GameMusicPerBeat.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameMusicPerBeat : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *Tone;
@property (nonatomic, copy) NSString *Chord_1;
@property (nonatomic, copy) NSString *Chord_2;
@property (nonatomic, copy) NSString *Chord_3;
@property (nonatomic, copy) NSString *Chord_4;
@property (nonatomic, copy) NSString *Chord_5;
@end
