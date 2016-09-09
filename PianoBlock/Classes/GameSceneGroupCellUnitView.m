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
#import "Masonry.h"

@interface GameSceneGroupCellUnitView()
@property BOOL isSpecial;
@end

@implementation GameSceneGroupCellUnitView{
    CALayer *_maskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetStatue];
        
        _maskLayer = [CALayer layer];
        _maskLayer.borderColor = self.layer.borderColor;
        _maskLayer.borderWidth = self.layer.borderWidth;
        _maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
        _maskLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _maskLayer.bounds = CGRectMake(0, 0, 20, 20);
    }
    return self;
}

- (void)loadSubview{
    WeakSelf
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        BOOL isSpecial = self.isSpecial;
        [weakSelf resetStatue];
        if ([_gameDelegate respondsToSelector:@selector(gameSceneCellBlockDidSelectedInblock:gameUnit:)]) {
            [_gameDelegate gameSceneCellBlockDidSelectedInblock:isSpecial gameUnit:weakSelf];
        }
    }];
}

- (void)startAnimate{
    self.layer.mask = _maskLayer;
    
    CAKeyframeAnimation *maskAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    maskAnimation.duration = 0.5;
    maskAnimation.beginTime = CACurrentMediaTime();
    
    CGRect initalBounds = _maskLayer.bounds;
    //CGRect secondBounds = CGRectMake(0, 0, 40, 40);
    CGRect finalBounds = CGRectMake(0, 0, 500, 500);
    maskAnimation.values = @[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:finalBounds]];
    maskAnimation.keyTimes = @[@(0),@(1)];
    maskAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.fillMode = kCAFillModeForwards;
    
    [self.layer.mask addAnimation:maskAnimation forKey:@"maskAnimation"];
     
}

- (void)resetStatue{
    _isSpecial = NO;
    [self.layer.mask removeAllAnimations];
    self.layer.mask = nil;
}

- (void)setToBeSpecialView{
    _isSpecial = YES;
}

- (BOOL)isSpecialView{
    return _isSpecial;
}

@end
