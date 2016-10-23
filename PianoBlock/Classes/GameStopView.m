//
//  GameStopView.m
//  PianoBlock
//
//  Created by JFChen on 16/10/15.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameStopView.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "GSCViewModel.h"

@implementation GameStopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)subViewSetupWithSceneVM:(GSCViewModel *)sceneVM{
    
    UILabel *gameScoreLabel = [[UILabel alloc] init];
    gameScoreLabel.textAlignment = NSTextAlignmentCenter;
    gameScoreLabel.text = [NSString stringWithFormat:@"%td",[sceneVM gameScore]];
    gameScoreLabel.font = [UIFont boldSystemFontOfSize:30];
    [self addSubview:gameScoreLabel];
    [gameScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(50);
        make.width.mas_equalTo(self);
        make.height.mas_lessThanOrEqualTo(self).multipliedBy(0.3);
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *bestScoreLabel = [[UILabel alloc] init];
    bestScoreLabel.textAlignment  = NSTextAlignmentCenter;
    bestScoreLabel.text = [NSString stringWithFormat:@"历史最高：%td",[sceneVM getHistoryBestScore]];
    bestScoreLabel.font = [UIFont systemFontOfSize:18 weight:18];
    [self addSubview:bestScoreLabel];
    [bestScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gameScoreLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(gameScoreLabel);
        make.height.mas_equalTo(gameScoreLabel).multipliedBy(0.5);
        make.centerX.mas_equalTo(self);
    }];
    
    UIButton *buttonMainScene = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonMainScene];
    [buttonMainScene setTitle:@"主页" forState:UIControlStateNormal];
    [buttonMainScene setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonMainScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_lessThanOrEqualTo(self).offset(-30);
        make.left.mas_lessThanOrEqualTo(self).offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    RACCommand *btnMainSceneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    buttonMainScene.rac_command = btnMainSceneCommand;
    self.backBtnSignal = btnMainSceneCommand.executionSignals;
    
    
    UIButton *buttonContinue = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonContinue];
    [buttonContinue setTitle:@"继续" forState:UIControlStateNormal];
    [buttonContinue setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_lessThanOrEqualTo(self).offset(-30);
        make.centerX.mas_lessThanOrEqualTo(self);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    RACCommand *btnContinueCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    buttonContinue.rac_command = btnContinueCommand;
    self.continueBtnSignal = btnContinueCommand.executionSignals;
    
    UIButton *buttonRestart = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonRestart];
    [buttonRestart setTitle:@"重玩" forState:UIControlStateNormal];
    [buttonRestart setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonRestart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_lessThanOrEqualTo(self).offset(-30);
        make.right.mas_lessThanOrEqualTo(self).offset(-20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    RACCommand *btnRstCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    buttonRestart.rac_command = btnRstCommand;
    self.replayBtnSignal = btnRstCommand.executionSignals;
}

@end
