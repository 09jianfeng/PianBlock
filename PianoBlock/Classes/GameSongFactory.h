//
//  GameSongFactory.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongAbstractFactory.h"

typedef NS_ENUM(char,GameSongDirectorType){
    GameSongDirectorTypeNormal,
    GameSongDirectorTypeNew
};

@interface GameSongFactory : NSObject

+ (id<AFSongDirectorDelegate>)gameSongFactoryMethod:(int)type;

@end
