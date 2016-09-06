//
//  GameSceneController+CellManage.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/6.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSceneController.h"

@interface GameSceneController (CellManage)
@property(nonatomic, strong) GameSceneVM *sceneViewModel;
@property(nonatomic, strong) GameSceneView *gameScene;
@end
