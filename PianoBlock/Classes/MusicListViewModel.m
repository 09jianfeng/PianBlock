//
//  MusicListViewModel.m
//  PianoBlock
//
//  Created by JFChen on 16/10/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "MusicListViewModel.h"
#import "GameBeatSongDirector.h"

@implementation MusicListViewModel

- (NSArray *)mListTableVCDataSource{
    NSArray *musicList = [[GameBeatSongDirector new] gameMusicList];
    return musicList;
}

@end
