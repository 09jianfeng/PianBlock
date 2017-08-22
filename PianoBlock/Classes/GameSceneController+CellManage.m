//
//  GameSceneController+CellManage.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/6.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneController+CellManage.h"
#import "GameSceneGroupCellUnitView.h"
#import "GSCViewModel.h"
#import "GameBLBGFactory.h"
#import "GameSceneView.h"
#import "ViewControllerSwitchMediator.h"
#import "GameStopView.h"
#import "Masonry.h"

@implementation GameSceneController (CellManage)
@dynamic sceneViewModel;
@dynamic gameScene;
@dynamic stopView;

#pragma mark - GameSceneViewDelegate,GameSceneViewDataSource
/// user did select unit view
- (void)gameSceneCellDidSelectedRightCell:(GameSceneGroupCellUnitView *)gameUnit{
    [self.sceneViewModel playSongNextBeat];
    [self.sceneViewModel increaseGameScore:1];
}

- (void)gameFail{
    [self showGameStopView];
}
@end
