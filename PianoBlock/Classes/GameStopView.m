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

@implementation GameStopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)subViewSetup{
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonBack];
    
    [buttonBack setTitle:@"返回" forState:UIControlStateNormal];
    [buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_lessThanOrEqualTo(self.mas_bottomMargin).offset(-20);
        make.left.mas_lessThanOrEqualTo(self.mas_left).offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    
    
    RACCommand *btnBackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    buttonBack.rac_command = btnBackCommand;
    self.backBtnSignal = btnBackCommand.executionSignals;
    
    
    UIButton *buttonHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonHome];
    
    [buttonHome setTitle:@"重玩" forState:UIControlStateNormal];
    [buttonHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottomMargin.mas_lessThanOrEqualTo(self.mas_bottomMargin).offset(-20);
        make.right.mas_lessThanOrEqualTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    
    RACCommand *btnHomeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    buttonHome.rac_command = btnHomeCommand;
    self.replayBtnSignal = btnHomeCommand.executionSignals;
}

@end
