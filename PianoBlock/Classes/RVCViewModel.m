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
    _buttonCommandBaofeng = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"select game mode");
        
        return [RACSignal empty];
    }];
    
    _buttonCommandJindian = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"select game mode");
        
        return [RACSignal empty];
    }];
    
    _buttonCommandShanbeng = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"select game mode");
        
        return [RACSignal empty];
    }];
    
    _buttonCommandLeiting = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"select game mode");
        
        return [RACSignal empty];
    }];
}

- (GSCViewModel *)viewModelForGameSceneInSong:(NSInteger )index{
    GameBeatSongBuilder *builder = [_songlists objectAtIndex:index];
    GSCViewModel *sceneVM = [[GSCViewModel alloc] initWithSong:[builder getSongProductResult]];
    sceneVM.gameMode = self.gameMode;
    return sceneVM;
}

@end
