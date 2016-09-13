//
//  ConcreteGameStreetMode.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ConcreteGameStreetMode.h"
#import "ProductGameModeStruct.h"

@implementation ConcreteGameStreetMode{
    ProductGameModeStruct *_gameStruct;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _gameStruct = [ProductGameModeStruct new];
    }
    return self;
}

- (ProductGameModeStruct *)AG_gameDataSource{
    return _gameStruct;
}

- (NSString *)AG_gameModel{
    return NSStringFromClass([self class]);
}

@end
