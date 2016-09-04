//
//  ViewControllerVM.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameSongProduct;
@interface GameSceneVM : NSObject

- (instancetype)initWithSong:(GameSongProduct *)song NS_DESIGNATED_INITIALIZER;

- (void)playSongNextBeat;

@end
