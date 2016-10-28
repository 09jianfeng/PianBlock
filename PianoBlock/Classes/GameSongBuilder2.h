//
//  GameSongBuilder2.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSongProduct2.h"

@interface GameSongBuilder2 : NSObject

- (void)buildProductWithJsonData:(NSData *)jsonData;

- (NSArray<GameSongProduct2 *> *)getSongProductList;

@end
