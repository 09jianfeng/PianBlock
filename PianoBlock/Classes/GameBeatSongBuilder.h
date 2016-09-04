//
//  GameBeatSong.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSongProduct.h"

@interface GameBeatSongBuilder : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *music;
@property (nonatomic, copy) NSString *price;

- (GameSongProduct *)getSongProductResult;

@end
