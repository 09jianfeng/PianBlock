//
//  GameBeatSong.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSongProduct.h"

@interface GameSongBuilder : NSObject

- (void)buildProductWithJsonData:(NSData *)jsonData;

- (NSArray<GameSongProduct *> *)getSongProductList;

@end
