//
//  GameModelFactory.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameMode.h"

@interface GameModelFactory : NSObject

+ (GameModelFactory *)classicGameDataSource;

+ (GameModelFactory *)streetGameDataSource;

- (void)gameScoresUpdate:(NSInteger)scores;

- (NSInteger)gameCurrentScores;

- (NSInteger)gameBestScores;

@end
