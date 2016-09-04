//
//  GameSceneControllerViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneControllerViewController.h"
#import "GameSceneView.h"
#import "GameCountdownWindow.h"

extern NSString *GAMESCENEUNITHITRIGHT ;
extern NSString *GAMESCENEUNITHITWRONG ;

@interface GameSceneControllerViewController ()
@property(nonatomic, strong) GameSceneView *gameScene;
@end

@implementation GameSceneControllerViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(correctClickEvent:) name:GAMESCENEUNITHITRIGHT object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)correctClickEvent:(id)sender{
    [_song playNextBeat];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
