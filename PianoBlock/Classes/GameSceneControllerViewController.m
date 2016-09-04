//
//  GameSceneControllerViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneControllerViewController.h"
#import "GameSceneView.h"
#import "GameCountdownWindow.h"
#import "ReactiveCocoa.h"

extern NSString *GAMESCENEUNITHITRIGHT ;
extern NSString *GAMESCENEUNITHITWRONG ;

@interface GameSceneControllerViewController ()
@property(nonatomic, strong) GameSceneView *gameScene;
@end

@implementation GameSceneControllerViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GAMESCENEUNITHITRIGHT object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.gameScene = [[GameSceneView alloc] initWithBlockNumPerLine:4 frame:self.view.bounds];
    self.gameScene.gameSpeed = 6.0;
    [self.view addSubview:self.gameScene];

    [[GameCountdownWindow shareInstance] showWithAnimNum:3 CompleteBlock:^{
        [self.gameScene startGame];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:GAMESCENEUNITHITRIGHT object:nil] subscribeNext:^(id  _Nullable x) {
        [_song playNextBeat];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
