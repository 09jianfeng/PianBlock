//
//  MusicListViewModel.m
//  PianoBlock
//
//  Created by JFChen on 16/10/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "MusicListViewModel.h"
#import "GameSongDirector2.h"

@implementation MusicListViewModel

// synchronization mode
- (void)mListTableVCDataSource:(void (^)(NSArray<id<AFSongProductDelegate>> *list))completeBlock{
    [[GameSongDirector2 new] gameMusicList:^(NSArray<id<AFSongProductDelegate>> *list) {
        completeBlock(list);
    }];
}

@end
