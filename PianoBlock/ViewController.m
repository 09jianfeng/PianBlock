//
//  ViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "OpenIDFA.h"
#import "GameSceneControllerViewController.h"
#import "GameCountdownWindow.h"
#import "GameBeatSongDirector.h"
#import "GameSongProduct.h"
#import "GameBeatSongBuilder.h"
#import "ReactiveCocoa.h"

@interface ViewController ()

@end

@implementation ViewController{
    GameSongProduct *product;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        GameBeatSongDirector *director = [GameBeatSongDirector new];
        GameBeatSongBuilder *builder = [[director gameMusicList] objectAtIndex:0];
        
        GameSceneControllerViewController *gameController = [[GameSceneControllerViewController alloc] init];
        gameController.song = [builder getSongProductResult];
        [self presentViewController:gameController animated:NO completion:nil];
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
