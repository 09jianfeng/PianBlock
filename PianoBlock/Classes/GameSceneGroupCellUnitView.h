//
//  GameSceneGroupCellUnitView.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"

@interface GameSceneGroupCellUnitView : UIButton
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;

- (void)loadSubview;

- (void)setToBeSpecialView;
- (BOOL)isSpecialView;

- (void)resetStatue;

- (void)startAnimate;

@end
