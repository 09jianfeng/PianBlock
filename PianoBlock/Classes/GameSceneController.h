//
//  GameSceneController.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSongProduct.h"
#import "RVCViewModel.h"
#import "GameSceneView.h"

@class GSCViewModel;

@interface GameSceneController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    sceneVM:(GSCViewModel *)sceneVM;

- (void)showGameStopView;
@end
