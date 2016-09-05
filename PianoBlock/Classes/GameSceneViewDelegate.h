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

/// user did select unit view
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock;

@end

@protocol GameSceneViewDataSource  <NSObject>

/// use to general group cell unit view
- (GameSceneGroupCellUnitView *)gameScreenGameCellUnit:(BOOL)isSpecial;

/// number of unit view per line
- (NSInteger)gameSceneUnitNumPerCell;

@end
