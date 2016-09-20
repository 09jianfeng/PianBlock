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

@interface RootViewController ()
@property (nonatomic , strong) ViewControllerVM *viewModel;
@end

@implementation RootViewController

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

@end
