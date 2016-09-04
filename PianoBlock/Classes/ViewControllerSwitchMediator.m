//
//  ViewControllerSwitchMediator.m
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ViewControllerSwitchMediator.h"
#import "GameCountdownWindow.h"
#import "GameBeatSongDirector.h"
#import "GameSongProduct.h"
#import "GameBeatSongBuilder.h"
#import "GameSceneControllerViewController.h"

@implementation ViewControllerSwitchMediator


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

- (void)showGameViewController:(UIViewController *)currentController{
    GameBeatSongDirector *director = [GameBeatSongDirector new];
    GameBeatSongBuilder *builder = [[director gameMusicList] objectAtIndex:0];
    
    GameSceneControllerViewController *gameController = [[GameSceneControllerViewController alloc] init];
    gameController.song = [builder getSongProductResult];
    [currentController presentViewController:gameController animated:NO completion:nil];

}


@end
