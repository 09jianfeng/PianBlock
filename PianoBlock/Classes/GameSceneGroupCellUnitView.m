//
//  GameSceneGroupCellUnitView.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneGroupCellUnitView.h"
#import "GameMacro.h"
#import "ReactiveCocoa.h"

NSString * const GAMESCENEUNITHITRIGHT = @"GAMESCENEUNITHITRIGHT";
NSString * const GAMESCENEUNITHITWRONG = @"GAMESCENEUNITHITWRONG";

@implementation GameSceneGroupCellUnitView{
    BOOL _isSpecial;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetStatue];
    }
    return self;
}

- (void)loadView{
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        if ([_gameDelegate respondsToSelector:@selector(gameSceneCellBlockDidSelectedInblock:)]) {
            [_gameDelegate gameSceneCellBlockDidSelectedInblock:_isSpecial];
        }
    }];
}

- (void)resetStatue{
    _isSpecial = NO;
}

- (void)setToBeSpecialView{
    _isSpecial = YES;
}

@end
