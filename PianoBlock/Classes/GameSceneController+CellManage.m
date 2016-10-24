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
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock gameUnit:(GameSceneGroupCellUnitView *)gameUnit{
    if (isSpecialBlock) {
        [self.sceneViewModel playSongNextBeat];
        [self.sceneViewModel increaseGameScore:1];
        [gameUnit startAnimate:[UIColor whiteColor] removeAnimateLayer:NO];
    }else{
        [self gameFail];
    }
}

- (void)gameFail{
    [self.gameScene stop];
    [self showGameStopView];
}

/// use to general group cell unit view
- (void)gameScreenGameCellUnit:(GameSceneGroupCellUnitView *)gameUnit{
    
    gameUnit.layer.borderWidth = 0.5;
    gameUnit.layer.borderColor = [UIColor grayColor].CGColor;
    if (gameUnit.isSpecial) {
        if (gameUnit.isSerial) {
            gameUnit.layer.borderWidth = 0.0;
        }
        gameUnit.layer.backgroundColor = [UIColor blackColor].CGColor;
    }else{
        gameUnit.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

/// number of unit view per line
- (NSInteger)gameSceneUnitNumPerCell{
    return 4;
}

@end
