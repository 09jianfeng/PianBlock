//
//  GSCViewModel.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "RVCViewModel.h"
#import "GameBeatSongDirector.h"
#import "GameBeatSongBuilder.h"
#import "GSCViewModel.h"
#import "MusicListViewModel.h"

@interface RVCViewModel()
@property (nonatomic, strong, readwrite) NSArray *songlists;
@end

@implementation RVCViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        GameBeatSongDirector *director = [GameBeatSongDirector new];
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
    GameBeatSongBuilder *builder = [_songlists objectAtIndex:index];
    GSCViewModel *sceneVM = [[GSCViewModel alloc] initWithSong:[builder getSongProductResult]];
    sceneVM.gameMode = self.gameMode;
    return sceneVM;
}

- (MusicListViewModel *)viewModelForMusicList{
    MusicListViewModel *mlViewModel = [[MusicListViewModel alloc] init];
    return mlViewModel;
}

@end
