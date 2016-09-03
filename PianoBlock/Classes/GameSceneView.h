//
//  GameSceneView.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"

@interface GameSceneView : UIView
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;
@property (nonatomic, weak) id<GameSceneViewDataSource> gameDataSource;
@property (nonatomic, assign) CGFloat gameSpeed;

- (instancetype)initWithBlockNumPerLine:(NSInteger)blockNum
                                  frame:(CGRect)frame __attribute__((objc_designated_initializer));

- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

- (void)startGame;

- (void)stop;

@end
