//
//  GameSceneController.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSongProduct.h"
#import "ViewControllerVM.h"

@class GameSceneVM;

@interface GameSceneController : UIViewController
@property(nonatomic, strong) GameSceneVM *sceneViewModel;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    sceneVM:(GameSceneVM *)sceneVM;

@end
