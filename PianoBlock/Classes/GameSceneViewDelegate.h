//
//  GameSceneViewDelegate.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameSceneGroupCellUnitView;

@protocol GameSceneViewDelegate  <NSObject>

@optional
/// user did select unit view
- (void)gameSceneCellDidSelectedRightCell:(GameSceneGroupCellUnitView *)gameUnit;
- (void)gameFail;

@end
