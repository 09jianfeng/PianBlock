//
//  GameModelFactory.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameModelFactory.h"
#import "ConcreteGameStreetMode.h"
#import "ConcreteGameClassicMode.h"
#import "AbstractGameMode.h"
#import "ProductGameModeStruct.h"

@implementation GameModelFactory{
    GameModelClass _gameMode;
    ProductGameModeStruct *_gameModeStruct;
}

- (instancetype)initWithGameMode:(GameModelClass)gameMode{
    self = [super init];
    if (self) {
        _gameMode = gameMode;
        _gameModeStruct = [_gameMode AG_gameDataSource];
    }
    return self;
}

+ (GameModelFactory *)classicGameDataSource{
    ConcreteGameStreetMode *gameMode = [ConcreteGameStreetMode new];
    return [[GameModelFactory alloc] initWithGameMode:gameMode];
}

+ (GameModelFactory *)streetGameDataSource{
    ConcreteGameClassicMode *gameMode = [ConcreteGameClassicMode new];
    return [[GameModelFactory alloc] initWithGameMode:gameMode];
}

- (void)gameScoresUpdate:(NSInteger)scores{
    _gameModeStruct.gameCurrentScores = scores;
}

- (NSInteger)gameCurrentScores{
    return _gameModeStruct.gameCurrentScores;
}

- (NSInteger)gameBestScores{
    return _gameModeStruct.gameBestScores;
}

@end
