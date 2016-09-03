//
//  GameSceneGroupCellUnitView.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneGroupCellUnitView.h"
#import "GameMacro.h"

NSString *GAMESCENEUNITHITRIGHT = @"GAMESCENEUNITHITRIGHT";
NSString *GAMESCENEUNITHITWRONG = @"GAMESCENEUNITHITWRONG";

@implementation GameSceneGroupCellUnitView{
    BOOL _isSpecial;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(cellClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)resetStatue{
    self.backgroundColor = [UIColor whiteColor];
    _isSpecial = NO;
}

- (void)setToBeSpecialView{
    self.backgroundColor = [UIColor blackColor];
    _isSpecial = YES;
}

- (void)cellClickEvent:(id)sender{
    if (_isSpecial) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAMESCENEUNITHITRIGHT object:nil];
        GAMELOG(@"good click");
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:GAMESCENEUNITHITWRONG object:nil];
        GAMELOG(@"bad click");
    }
}

@end
