//
//  ViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "RootViewController.h"
#import "Masonry.h"
#import "ViewControllerSwitchMediator.h"
#import "ReactiveCocoa.h"
#import "RVCViewModel.h"
#import "MainGameScene.h"
#import "GameMacro.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface RootViewController ()
@property (nonatomic , strong) RVCViewModel *viewModel;
@end

@implementation RootViewController{
    BouncePresentAnimation *_presentAnim;
    NormalDismissAnimation *_dismissAnim;
    SwipeUpInteractiveTransition *_interactiveAnim;
    MainGameScene *_mainScene;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _presentAnim = [BouncePresentAnimation new];
        _dismissAnim = [NormalDismissAnimation new];
        _interactiveAnim = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RVCViewModel *viewModel = [RVCViewModel new];
    
    _mainScene = [[MainGameScene alloc] initWithButtonNumPerLine:4 frame:self.view.bounds];
    [self.view addSubview:_mainScene];
    
    WeakSelf;
    [[_mainScene gameRACForButtonAtIndex:GAMEMAINMANU_MusicList bindCommand:viewModel.btnCommandMusicList]
    subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showMusciListVC:weakSelf RVCViewModel:viewModel];
    }];
    
    [[_mainScene gameStarButonCommandBind:viewModel._btnCommandGameStar] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf RVCViewModel:viewModel];
    }];
    
    [_interactiveAnim wireToViewController:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_mainScene beginMainSceneAnimation];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [_mainScene stopMainSceneAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VCAnimateTransition
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return (id <UIViewControllerAnimatedTransitioning>)_presentAnim;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return (id <UIViewControllerAnimatedTransitioning>)_dismissAnim;
}

@end
