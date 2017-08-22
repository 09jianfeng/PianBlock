//
//  GameSongFactory.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongFactory.h"
#import "GameSongDirector.h"
#import "GameSongDirector2.h"

@implementation GameSongFactory

+ (id<AFSongDirectorDelegate>)gameSongFactoryMethod:(int)type{
    switch (type) {
        case GameSongDirectorTypeNormal:
            return [GameSongDirector new];
            break;
            
        case GameSongDirectorTypeNew:
            return [GameSongDirector new];
            break;
        
        default:
            break;
    }
    return nil;
}

@end
