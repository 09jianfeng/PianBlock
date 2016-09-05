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

extern NSString *GAMESCENEUNITHITRIGHT ;
extern NSString *GAMESCENEUNITHITWRONG ;

@interface GameSceneController () <GameSceneViewDelegate,GameSceneViewDataSource>
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
    _gameScene = [[GameSceneView alloc] initWithBlockNumPerLine:4 frame:self.view.bounds];
    _gameScene.gameSpeed = 6.0;
    _gameScene.gameDelegate = self;
    _gameScene.gameDataSource = self;
    [_gameScene loadGameScene];
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

#pragma mark - GameSceneViewDelegate,GameSceneViewDataSource
/// user did select unit view
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock{
    if (isSpecialBlock) {
        [_sceneViewModel playSongNextBeat];
    }
}

/// use to general group cell unit view
- (GameSceneGroupCellUnitView *)gameScreenGameCellUnit:(BOOL)isSpecial{
    GameSceneGroupCellUnitView *unitView = [[GameSceneGroupCellUnitView alloc] init];
    unitView.backgroundColor = [UIColor blueColor];
    if (isSpecial) {
        unitView.backgroundColor = [UIColor blackColor];
    }
    //UIImage *image = [UIImage imageNamed:@"black_block"];
    //self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    return unitView;
}

/// number of unit view per line
- (NSInteger)gameSceneUnitNumPerCell{
    return 6;
}

@end
