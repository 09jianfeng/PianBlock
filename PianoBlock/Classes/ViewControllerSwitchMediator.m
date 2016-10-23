//
//  ViewControllerSwitchMediator.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ViewControllerSwitchMediator.h"
#import "GameCountdownWindow.h"
#import "GameSceneController.h"
#import "RootViewController.h"
#import "MusicListViewModel.h"
#import "MusicListTableViewController.h"

@implementation ViewControllerSwitchMediator{
    UIViewController *_fatherController;
}


#pragma mark - 创建单例

static ViewControllerSwitchMediator *_instance;

+ (instancetype)shareInstance{
    return [self new];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}

- (id)copy{
    return _instance;
}

- (id)mutableCopy{
    return _instance;
}

#pragma mark - controller switch
// game playing vc
- (void)showGameViewController:(RootViewController *)currentController RVCViewModel:(RVCViewModel *)viewModel{
    
    GameSceneController *gameController = [[GameSceneController alloc] initWithNibName:nil bundle:nil sceneVM:[viewModel viewModelForGameSceneInSong:0]];
    gameController.transitioningDelegate = currentController;
    [currentController presentViewController:gameController animated:YES completion:nil];
    _fatherController = currentController;

}

// music list controller
- (void)showMusciListVC:(RootViewController *)currentController RVCViewModel:(RVCViewModel *)viewModel{
    
    MusicListTableViewController *musicListVC = [[MusicListTableViewController alloc] init];
    musicListVC.mlViewModel = [viewModel viewModelForMusicList];
    musicListVC.transitioningDelegate = currentController;
    [currentController presentViewController:musicListVC animated:YES completion:nil];
    _fatherController = currentController;
}

- (void)dismissCurrentController{
    [_fatherController dismissViewControllerAnimated:YES completion:nil];
}

@end
