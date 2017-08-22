//
//  GameSceneGroupCellUnitView.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"

typedef NS_ENUM(char,SerialType) {
    SerialTypeNotSerial,
    SerialTypeNormal,
    SerialTypeTop
};

@interface GameSceneGroupCellUnitView : UIButton
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;
@property(nonatomic, assign) BOOL isSpecial;
@property(nonatomic, assign) SerialType serialType;

- (void)setToBeSpecialViewWithSerialType:(SerialType)serialType;
- (BOOL)isSpecialView;

- (void)reuseUnitView;

- (void)startCellAnimation:(UIColor *)layerColor removeAnimateLayer:(BOOL)removeAniLayer;

- (void)buttonPressedEventIsSerial:(SerialType)serialType;

- (void)redrawSublayerWithTouchPosition:(CGPoint)point;

@end
