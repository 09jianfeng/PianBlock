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

@interface GameSceneController () <GameSceneViewDelegate>
@property(nonatomic, strong) GSCViewModel *sceneViewModel;
@property(nonatomic, strong) GameSceneView *gameScene;
@property(nonatomic, strong) GameStopView *stopView;
@end

@implementation GameSceneController

- (void)dealloc{
    NSLog(@"GameSceneController dealloc");
}

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
    [self initialSubviews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - subviews

- (void)initialSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    _gameScene = [[GameSceneView alloc] initWithBlockNumPerLine:4 frame:self.view.bounds];
    _gameScene.gameSpeed = 4.0;
    _gameScene.gameDelegate = self;
    _gameScene.gameMode = GAMEMODE_AUTOROLLMUTLCLICK;
    [_gameScene loadSubView];
    [self.view addSubview:self.gameScene];
    
    WeakSelf;
    [[GameCountdownWindow shareInstance] showWithAnimNum:1 CompleteBlock:^{
        [weakSelf.gameScene startGame];
    }];
    
    UILabel *gameScoreTips = [[UILabel alloc] init];
    gameScoreTips.text = @"0";
    gameScoreTips.textColor = [UIColor redColor];
    gameScoreTips.font = [UIFont boldSystemFontOfSize:30];
    gameScoreTips.textAlignment = NSTextAlignmentCenter;
    gameScoreTips.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gameScoreTips];
    [gameScoreTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.3);
        make.height.mas_equalTo(@30);
    }];
    
    [RACObserve(_sceneViewModel,gameScore) subscribeNext:^(NSNumber *score) {
        gameScoreTips.text = [NSString stringWithFormat:@"%@",score];
    }];
}

- (void)showGameStopView{
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.tag = 1001;
    
    self.stopView = [[GameStopView alloc] init];
    self.stopView.alpha = 1.0;
    self.stopView.layer.cornerRadius = 10.0;
    self.stopView.layer.borderColor = [UIColor blackColor].CGColor;
    self.stopView.layer.borderWidth = 3.0;
    self.stopView.backgroundColor = [UIColor whiteColor];
    [self.stopView subViewSetupWithSceneVM:self.sceneViewModel];
    [self buttonSignalSubscribe];
    [self.view addSubview:self.stopView];
    
    [self.stopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-100);
        make.width.mas_equalTo(self.view).multipliedBy(0.8);
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
        make.centerY.mas_equalTo(self.view);
    }];
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //If using updateConstraintsIfNeeded instead of layoutIfNeeded, animation won't happen.
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)buttonSignalSubscribe{
    WeakSelf;
    [self.stopView.backBtnSignal subscribeNext:^(id  _Nullable x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.stopView.continueBtnSignal subscribeNext:^(id  _Nullable x) {
        [weakSelf continueGame];
    }];
    
    [self.stopView.replayBtnSignal subscribeNext:^(id  _Nullable x) {
        [weakSelf restartGame];
    }];
}

- (void)continueGame{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self initialSubviews];

}

- (void)restartGame{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.sceneViewModel clearGameScore];
    [self initialSubviews];
}

@end
