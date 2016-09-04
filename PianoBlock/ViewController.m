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
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView *superView = self.view;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.topMargin.mas_equalTo(50);
    }];
}

- (void)buttonPressed:(id)sender{
  //  GameSceneControllerViewController *gameController = [[GameSceneControllerViewController alloc] init];
  //  [self presentViewController:gameController animated:NO completion:nil];
    [self testPlaysong];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testPlaysong{
    GameBeatSongDirector *director = [GameBeatSongDirector new];
    NSArray *songList = [director gameMusicList];
    GameBeatSongBuilder *builder = songList[0];
    product = [builder getSongProductResult];
    //while (1) {
    [product playNextBeat];
    //}
}

@end
