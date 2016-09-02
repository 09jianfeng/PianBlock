//
//  GameSceneControllerViewController.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneControllerViewController.h"
#import "GameSceneView.h"

@interface GameSceneControllerViewController ()

@end

@implementation GameSceneControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    GameSceneView *gameScene = [[GameSceneView alloc] initWithBlockNumPerLine:4 frame:self.view.bounds];
    [self.view addSubview:gameScene];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
