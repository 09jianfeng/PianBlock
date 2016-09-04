//
//  ViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ViewControllerSwitchMediator.h"
#import "ReactiveCocoa.h"
#import "ViewControllerVM.h"

@interface ViewController ()
@property (nonatomic , strong) ViewControllerVM *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ViewControllerVM *viewModel = [ViewControllerVM new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    __weak typeof(self) weakSelf = self;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        [[ViewControllerSwitchMediator shareInstance] showGameViewController:weakSelf viewControllerVM:viewModel];
    }];
    
    UIView *superView = self.view;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.topMargin.mas_equalTo(50);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
