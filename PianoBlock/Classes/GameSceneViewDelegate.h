//
//  GameSceneViewDelegate.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameSceneGroupCell;
@protocol GameSceneViewDelegate  <NSObject>

- (void)gameScreenDidSelectedAtItem:(GameSceneGroupCell *)groupCell;

@end

@protocol GameSceneViewDataSource  <NSObject>

@end