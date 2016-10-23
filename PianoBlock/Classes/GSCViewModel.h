//
//  RVCViewModel.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainGameScene.h"

@class GameSongProduct;

@interface GSCViewModel : NSObject
@property(nonatomic, assign) GAMEMAINMANU gameMode;
@property(nonatomic, assign) NSInteger gameScore;

- (instancetype)initWithSong:(GameSongProduct *)song NS_DESIGNATED_INITIALIZER;
- (void)playSongNextBeat;

- (UIImage *)getSpecialBlockBGImage;
- (UIImage *)getNormalBlockBGImage;

- (void)increaseGameScore:(NSInteger)point;
- (void)decreaseGameScore:(NSInteger)point;
- (void)clearGameScore;

- (NSInteger)getHistoryBestScore;
@end
