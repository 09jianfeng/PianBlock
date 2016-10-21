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
#import "GSCViewModel.h"
#import "GameSceneViewDelegate.h"
#import "GameSceneGroupCellUnitView.h"
#import "GameStopView.h"
#import "Masonry.h"
#import "GameMacro.h"

@interface GameSceneController () <GameSceneViewDelegate,GameSceneViewDataSource>
@property(nonatomic, strong) GSCViewModel *sceneViewModel;
@property(nonatomic, strong) GameSceneView *gameScene;
@property(nonatomic, strong) GameStopView *stopView;
@end

@implementation GameSceneController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    sceneVM:(GSCViewModel *)sceneVM{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _sceneViewModel = sceneVM;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil sceneVM:[GSCViewModel new]];
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

    [[GameCountdownWindow shareInstance] showWithAnimNum:1 CompleteBlock:^{
        [self.gameScene startGame:GAMEMODE_AUTOROLL];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)showGameStopView{
    self.stopView = [[GameStopView alloc] init];
    self.stopView.alpha = 1.0;
    self.stopView.backgroundColor = [UIColor grayColor];
    [self.stopView subViewSetup];
    [self.view addSubview:self.stopView];
    
    [self.stopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(60);
        make.top.mas_equalTo(self.view).offset(-200);
        make.right.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(self.view).multipliedBy(0.6);
    }];
    
    [self.view layoutIfNeeded];
    
    /* different between setNeedsUpdateConstraints setNeedsLayout updateConstraintsIfNeeded setNeedsLayout
     http://stackoverflow.com/questions/20609206/setneedslayout-vs-setneedsupdateconstraints-and-layoutifneeded-vs-updateconstra
     
     setNeedsUpdateConstraints makes sure a future call to updateConstraintsIfNeeded calls updateConstraints.
     setNeedsLayout makes sure a future call to layoutIfNeeded calls layoutSubviews.
     
     -updateConstraintsIfNeeded only update constraints but doesn't force the layout to come into the process imediately, thus original frames are still preserved
     -layoutIfNeeded calls also -updateContraints method and update subviews layout imediately
     */
    // UIView animation only re-lays-out the view based on differences between the old and new ones.
    [self.stopView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
    }];
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //If using updateConstraintsIfNeeded instead of layoutIfNeeded, animation won't happen.
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [self buttonSignalSubscribe];
}

- (void)buttonSignalSubscribe{
    WeakSelf;
    [self.stopView.backBtnSignal subscribeNext:^(id  _Nullable x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.stopView.replayBtnSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"返回主页");
    }];
}

@end
