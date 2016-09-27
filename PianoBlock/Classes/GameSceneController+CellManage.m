//
//  GameSceneController+CellManage.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/6.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneController+CellManage.h"
#import "GameSceneGroupCellUnitView.h"
#import "GameSceneVM.h"
#import "GameBLBGFactory.h"
#import "GameSceneView.h"
#import "ViewControllerSwitchMediator.h"

@implementation GameSceneController (CellManage)
@dynamic sceneViewModel;
@dynamic gameScene;

#pragma mark - GameSceneViewDelegate,GameSceneViewDataSource
/// user did select unit view
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock gameUnit:(GameSceneGroupCellUnitView *)gameUnit{
    if (isSpecialBlock) {
        [self.sceneViewModel playSongNextBeat];
        [gameUnit startAnimate:[UIColor whiteColor] removeAnimateLayer:NO];
    }else{
        [self.gameScene stop];
        [[ViewControllerSwitchMediator shareInstance] dismissCurrentController];
    }
}

- (void)gameFail{
    [self.gameScene stop];
}

/// use to general group cell unit view
- (void)gameScreenGameCellUnit:(BOOL)isSpecial gameUnit:(GameSceneGroupCellUnitView *)gameUnit{
    
    gameUnit.layer.borderWidth = 1.0;
    gameUnit.layer.borderColor = [UIColor grayColor].CGColor;
    if (isSpecial) {
        gameUnit.layer.contents = (__bridge id _Nullable)([[self.sceneViewModel getSpecialBlockBGImage] CGImage]);
    }else{
        gameUnit.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

/// number of unit view per line
- (NSInteger)gameSceneUnitNumPerCell{
    return 4;
}

@end
