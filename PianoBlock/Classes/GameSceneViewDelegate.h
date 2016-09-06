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
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock gameUnit:(GameSceneGroupCellUnitView *)gameUnit;
- (void)gameFail;

@end


@protocol GameSceneViewDataSource  <NSObject>

@optional
/// use to self-define group cell unit view
- (void)gameScreenGameCellUnit:(BOOL)isSpecial gameUnit:(GameSceneGroupCellUnitView *)gameUnit;

/// number of unit view per line
- (NSInteger)gameSceneUnitNumPerCell;

@end
