//
//  GameStarButton.m
//  PianoBlock
//
//  Created by JFChen on 16/10/23.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameStarButton.h"

@interface GameStarButton() <CAAnimationDelegate>
@property(nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation GameStarButton{
    BOOL _isStop;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)beginAnimations{
    _isStop = NO;
    
    CAKeyframeAnimation *kfAnimateScale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D initTransform = CATransform3DMakeScale(1, 1, 0);
    CATransform3D finalTransform = CATransform3DMakeScale(1.5, 1.5, 0);
    kfAnimateScale.values = @[[NSValue valueWithCATransform3D:initTransform],[NSValue valueWithCATransform3D:finalTransform]];
    kfAnimateScale.keyTimes = @[@0,@1];
    kfAnimateScale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    kfAnimateScale.duration = 1;
    kfAnimateScale.delegate = self;
    kfAnimateScale.removedOnCompletion = YES;
    kfAnimateScale.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *kfAnimateAlpha = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimateAlpha.values = @[@1.0,@0.0];
    kfAnimateAlpha.keyTimes = @[@0,@1];
    kfAnimateAlpha.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    kfAnimateAlpha.duration = 1;
    kfAnimateAlpha.delegate = self;
    kfAnimateAlpha.removedOnCompletion = YES;
    kfAnimateAlpha.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.autoreverses = NO;
    group.duration = 1.0;
    group.animations = @[kfAnimateScale,kfAnimateAlpha];
    group.removedOnCompletion = YES;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.backgroundColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.6 alpha:0.5].CGColor;
    [self.layer addSublayer:_shapeLayer];
    [_shapeLayer addAnimation:group forKey:@"GameStartAnimation"];
}

- (void)updateConstraints{
    [super updateConstraints];
}

- (void)layoutSubviews{
    _shapeLayer.frame = self.bounds;
    _shapeLayer.cornerRadius = self.layer.cornerRadius;
    [super layoutSubviews];
}

- (void)stopAnimations{
    _isStop = YES;
    [_shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
}

#pragma mark - CAAnimation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_shapeLayer removeFromSuperlayer];
    if (!_isStop) {
        [self beginAnimations];
    }
}

@end
