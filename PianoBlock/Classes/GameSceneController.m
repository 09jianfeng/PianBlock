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

extern NSString *GAMESCENEUNITHITRIGHT ;
extern NSString *GAMESCENEUNITHITWRONG ;

@interface GameSceneController ()
@property(nonatomic, strong) GameSceneView *gameScene;
@property(nonatomic, strong) GameSceneVM *sceneViewModel;
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
        [_sceneViewModel playSongNextBeat];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildGameSceneControllerVMWithRootVM:(ViewControllerVM *)rootVM{
    
}

@end
