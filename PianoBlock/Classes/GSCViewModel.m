//
//  RVCViewModel.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GSCViewModel.h"
#import "GameBLBGFactory.h"

@implementation GSCViewModel{
    id<AFSongProductDelegate> _song;
    GameBLBGFactory *_blockBackgroundFactory;
}

- (instancetype)initWithSong:(id<AFSongProductDelegate>)song{
    self = [super init];
    if (self) {
        _song = song;
        _blockBackgroundFactory = [GameBLBGFactory new];
    }
    return self;
}

- (instancetype)init{
    return [self initWithSong:nil];
}

- (void)playSongNextBeat{
    [_song playNextBeat];
}

- (UIImage *)getSpecialBlockBGImage{
    return [_blockBackgroundFactory blockBackgroundWithType:BLBackgroundTypeBlack];
}

- (UIImage *)getNormalBlockBGImage{
    return [_blockBackgroundFactory blockBackgroundWithType:BLBackgroundTypeWhite];
}

- (void)increaseGameScore:(NSInteger)point{
    self.gameScore += point;
}

- (void)decreaseGameScore:(NSInteger)point{
    self.gameScore -= point;
}

- (void)clearGameScore{
    self.gameScore = 0;
}

- (NSInteger)getHistoryBestScore{
    return 8888;
}

@end
