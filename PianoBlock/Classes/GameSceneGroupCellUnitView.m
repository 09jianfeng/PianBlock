//
//  GameSceneGroupCellUnitView.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneGroupCellUnitView.h"

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

- (void)setToBeSpecialView{
    self.backgroundColor = [UIColor blackColor];
    _isSpecial = YES;
}

- (void)cellClickEvent:(id)sender{
    if (_isSpecial) {
        
    }
    
    NSLog(@"block click");
}

@end
