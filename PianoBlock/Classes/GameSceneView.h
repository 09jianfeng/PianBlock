//
//  GameSceneView.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSceneViewDelegate.h"

typedef NS_ENUM(NSInteger,GAMEMODE){
    GAMEMODE_AUTOROLL,
    GAMEMODE_AUTOROLLMUTLCLICK,
    GAMEMODE_MANUALROLL
};

@interface GameSceneView : UIView
@property (nonatomic, weak) id<GameSceneViewDelegate> gameDelegate;
@property (nonatomic, assign) CGFloat gameSpeed;
@property (nonatomic, assign) GAMEMODE gameMode;

- (instancetype)initWithBlockNumPerLine:(NSInteger)blockNum
                                  frame:(CGRect)frame __attribute__((objc_designated_initializer));

- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

- (void)loadSubView;
- (void)startGame;

- (void)stop;
- (void)contine;

@end
