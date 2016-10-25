//
//  GameSceneGroupCell.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"
#import "GameSceneGroupCellUnitView.h"

@interface GameSceneGroupCell : UIView
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;

- (instancetype)initWithUnitCellsNum:(NSInteger)blockNums
                               frame:(CGRect)frame
                     randomColorsNum:(NSInteger)randomColorsNum __attribute__((objc_designated_initializer));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

- (void)loadSubCells:(int)sepcialIndex serialType:(SerialType)serialType;
- (void)reuseSubCells:(int)sepcialIndex serialType:(SerialType)serialType;

- (BOOL)isHaveSpecialUnitView;

- (BOOL)toucheInPoint:(CGPoint)point isHaveClickRightBlockBefor:(BOOL)isHaveClickRightBlockBefor serialType:(SerialType)serialType;

- (void)updateSpecialUnitViewSerialType:(SerialType)serialType specialBlockIndex:(NSInteger)specialBlockIndex;

@end
