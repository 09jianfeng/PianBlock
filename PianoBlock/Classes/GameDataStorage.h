//
//  GameDataStorage.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/13.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameMode.h"

@interface GameDataStorage : NSObject

+ (void)updateGameHighestScoresInMode:(GameModelClass)gameModel;
+ (NSInteger)getGameHighestScoresInModel:(GameModelClass)gamemodel;

@end
