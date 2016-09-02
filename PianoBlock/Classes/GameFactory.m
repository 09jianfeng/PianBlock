//
//  GameFactory.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameFactory.h"
#import "ConcreteGameStreetMode.h"
#import "ConcreteGameClassicMode.h"

@implementation GameFactory

+ (GameDataSourceClass)classicGameDataSource{
    return [ConcreteGameClassicMode new];
}

+ (GameDataSourceClass)streetGameDataSource{
    return [ConcreteGameClassicMode new];
}

@end
