//
//  GameSceneGroupCell.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"

@interface GameSceneGroupCell : UIView
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;
@property (nonatomic, weak) id<GameSceneViewDataSource> gameDataSource;

- (instancetype)initWithUnitCellsNum:(NSInteger)blockNums
                               frame:(CGRect)frame
                     randomColorsNum:(NSInteger)randomColorsNum __attribute__((objc_designated_initializer));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

- (void)loadSubView;
- (void)reuseGroupCell;

- (BOOL)isHaveSpecialUnitView;

@end
