//
//  GameSceneVM.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ViewControllerVM.h"
#import "GameBeatSongDirector.h"
#import "GameBeatSongBuilder.h"
#import "GameSceneVM.h"

@interface ViewControllerVM()

@property (nonatomic, strong, readwrite) NSArray *songlists;

@end

@implementation ViewControllerVM

- (instancetype)init{
    self = [super init];
    if (self) {
        GameBeatSongDirector *director = [GameBeatSongDirector new];
        _songlists = [director gameMusicList];
    }
    return self;
}

- (GameSceneVM *)viewModelForGameSceneInSong:(NSInteger )index{
    GameBeatSongBuilder *builder = [_songlists objectAtIndex:index];
    GameSceneVM *sceneVM = [[GameSceneVM alloc] initWithSong:[builder getSongProductResult]];
    return sceneVM;
}

@end
