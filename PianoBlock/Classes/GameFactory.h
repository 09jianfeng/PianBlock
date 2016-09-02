//
//  GameFactory.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGame.h"

@interface GameFactory : NSObject

+ (GameDataSourceClass)classicGameDataSource;

+ (GameDataSourceClass)streetGameDataSource;

@end
