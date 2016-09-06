//
//  GameSceneController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneController.h"
#import "GameSceneView.h"
#import "GameCountdownWindow.h"
#import "ReactiveCocoa.h"
#import "GameSceneVM.h"
#import "GameSceneViewDelegate.h"
#import "GameSceneGroupCellUnitView.h"

@interface GameSceneController () <GameSceneViewDelegate,GameSceneViewDataSource>
@property(nonatomic, strong) GameSceneVM *sceneViewModel;
@property(nonatomic, strong) GameSceneView *gameScene;
@end

@implementation GameSceneController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    sceneVM:(GameSceneVM *)sceneVM{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _sceneViewModel = sceneVM;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil sceneVM:[GameSceneVM new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _gameScene = [[GameSceneView alloc] initWithBlockNumPerLine:4 frame:self.view.bounds];
    _gameScene.gameSpeed = 4.0;
    _gameScene.gameDelegate = self;
    _gameScene.gameDataSource = self;
    [_gameScene loadSubView];
    [self.view addSubview:self.gameScene];

    [[GameCountdownWindow shareInstance] showWithAnimNum:3 CompleteBlock:^{
        [self.gameScene startGame];
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
