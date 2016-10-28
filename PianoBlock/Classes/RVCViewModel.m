//
//  GSCViewModel.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "RVCViewModel.h"
#import "GameSongDirector.h"
#import "GameSongBuilder.h"
#import "GSCViewModel.h"
#import "MusicListViewModel.h"
#import "GameSongFactory.h"

@interface RVCViewModel()
@property (nonatomic, strong, readwrite) NSArray *songlists;
@end

@implementation RVCViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        id<AFSongDirectorDelegate> director = [GameSongFactory gameSongFactoryMethod:GameSongDirectorTypeNormal];
        _songlists = [director gameMusicList];
        [self bindButtonClickEvent];
    }
    return self;
}

- (void)bindButtonClickEvent{
    
    __btnCommandGameStar = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"select game mode");
        
        return [RACSignal empty];
    }];
    
    _btnCommandMusicList = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"show music list");
        
        return [RACSignal empty];
    }];
}

#pragma mark - 返回子ViewModel

- (GSCViewModel *)viewModelForGameSceneInSong:(NSInteger )index{
    id<AFSongProductDelegate> song = [_songlists objectAtIndex:index];
    [song cacheAudio];
    GSCViewModel *sceneVM = [[GSCViewModel alloc] initWithSong:song];
    sceneVM.gameMode = self.gameMode;
    return sceneVM;
}

- (MusicListViewModel *)viewModelForMusicList{
    MusicListViewModel *mlViewModel = [[MusicListViewModel alloc] init];
    return mlViewModel;
}

@end
