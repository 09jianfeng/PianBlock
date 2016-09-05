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
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
            if (_isSpecial) {
                [[NSNotificationCenter defaultCenter] postNotificationName:GAMESCENEUNITHITRIGHT object:nil];
                [self resetStatue];
                GAMELOG(@"good click");
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:GAMESCENEUNITHITWRONG object:nil];
                GAMELOG(@"bad click");
            }
        }];
        
        [self resetStatue];
    }
    return self;
}

- (void)resetStatue{
    UIImage *image = [UIImage imageNamed:@"white_block"];
    self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    _isSpecial = NO;
}

- (void)setToBeSpecialView{
    UIImage *image = [UIImage imageNamed:@"black_block"];
    self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    _isSpecial = YES;
}

@end
