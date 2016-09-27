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
#import "ViewControllerVM.h"
#import "MainGameScene.h"
#import "GameMacro.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface RootViewController ()
@property (nonatomic , strong) ViewControllerVM *viewModel;
@end

@implementation RootViewController{
    BouncePresentAnimation *_presentAnim;
    NormalDismissAnimation *_dismissAnim;
    SwipeUpInteractiveTransition *_interactiveAnim;
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
    
    ViewControllerVM *viewModel = [ViewControllerVM new];
    
    MainGameScene *mainScene = [[MainGameScene alloc] initWithButtonNumPerLine:4 frame:self.view.bounds];
    [self.view addSubview:mainScene];
    
    WeakSelf;
    [[mainScene gameRACForButtonAtIndex:GAMEMAINMANU_JINDIAN] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    [[mainScene gameRACForButtonAtIndex:GAMEMAINMANU_LEITING] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    [[mainScene gameRACForButtonAtIndex:GAMEMAINMANU_SHANBENG] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    [[mainScene gameRACForButtonAtIndex:GAMEMAINMANU_BAOFENG] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    [_interactiveAnim wireToViewController:self];
    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    UIView *superView = self.view;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.topMargin.mas_equalTo(50);
    }];
     */
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
