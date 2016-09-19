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

@interface GameSceneGroupCellUnitView() <CAAnimationDelegate>
@property BOOL isSpecial;
@end

@implementation GameSceneGroupCellUnitView{
    CALayer *_maskLayer;
    CAShapeLayer *_shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self reuseUnitView];
    }
    return self;
}

- (void)loadSubview{
    WeakSelf
    [[self rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id  _Nullable x) {
        BOOL isSpecial = self.isSpecial;
        self.isSpecial = NO;
        if ([_gameDelegate respondsToSelector:@selector(gameSceneCellBlockDidSelectedInblock:gameUnit:)]) {
            [_gameDelegate gameSceneCellBlockDidSelectedInblock:isSpecial gameUnit:weakSelf];
        }
    }];
}

- (void)startAnimate{
    [self bezierPathAnimation];
}

- (void)maskLayerAnimation{
    
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.borderColor = self.layer.borderColor;
        _maskLayer.borderWidth = self.layer.borderWidth;
        _maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
        _maskLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _maskLayer.bounds = CGRectMake(0, 0, 20, 20);
    }
    
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

- (void)bezierPathAnimation{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = [UIColor grayColor].CGColor;
        _shapeLayer.lineWidth = 0.0;
        _shapeLayer.fillColor = [UIColor grayColor].CGColor;
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.path = path.CGPath;
        _shapeLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    [self.layer addSublayer:_shapeLayer];
    self.layer.masksToBounds = YES;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D initialTransform = CATransform3DMakeScale(1, 1, 0);
    CATransform3D finalTransform = CATransform3DMakeScale(8, 8, 0);
    animation.values = @[[NSValue valueWithCATransform3D:initialTransform],[NSValue valueWithCATransform3D:finalTransform]];
    animation.keyTimes = @[@(0),@(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 0.5;
    animation.beginTime = CACurrentMediaTime();
    animation.delegate = self;
    
    [_shapeLayer addAnimation:animation forKey:@"transformAnimation"];
}

- (void)reuseUnitView{
    _isSpecial = NO;
    [_shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
    [self.layer.mask removeAllAnimations];
    self.layer.mask = nil;
    self.layer.contents = nil;
}

- (void)setToBeSpecialView{
    _isSpecial = YES;
}

- (BOOL)isSpecialView{
    return _isSpecial;
}

#pragma mark - CAAnimation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self reuseUnitView];
}

@end
