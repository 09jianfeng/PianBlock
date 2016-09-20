//
//  GameSceneVM.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MainGameScene.h"

@class GameSongProduct;
@class GameSceneVM;

@interface ViewControllerVM : NSObject
@property (nonatomic, strong, readonly) NSArray *songlists;
@property(nonatomic, assign) GAMEMAINMANU gameMode;

- (void)setGameMode:(GAMEMAINMANU)gameMode;
- (GAMEMAINMANU)gameMode;

/*
 *参考 http://www.sprynthesis.com/2014/12/06/reactivecocoa-mvvm-introduction/
 *
 * Strictly speaking, you should create a view-model for your top view-controller in your app delegate. When presenting a new view controller, or bit of view that’s represented by a view-model, you ask the current view-model to create the child view-model for you.
 * 说明了 viewController切换的时候，对应的VM 切换的问题。 建议 给rootViewController 创建对应的VM，然后rootViewController 切换 子Controller的时候。  对应的 VM 生成 子 VM传给  子Controller。
 */
- (GameSceneVM *)viewModelForGameSceneInSong:(NSInteger )index;


@end
