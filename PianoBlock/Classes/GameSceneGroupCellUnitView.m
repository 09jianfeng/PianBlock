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
@property(nonatomic, strong) dispatch_source_t timer;
@end

@implementation GameSceneGroupCellUnitView{
    CALayer *_maskLayer;
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_dynamicShapeLayer;
    CALayer *_lineLayer;
    CALayer *_graphLayer;
    BOOL _clicked;
}

- (void)dealloc{
    NSLog(@"GameSceneGroupCellUnitView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self reuseUnitView];
    }
    return self;
}

- (void)reuseUnitView{
    _clicked = NO;
    _isSpecial = NO;
    _serialType = NO;
    [_shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
    
    [_lineLayer removeFromSuperlayer];
    [_graphLayer removeFromSuperlayer];
    
    [_dynamicShapeLayer removeFromSuperlayer];
    [self.layer.mask removeAllAnimations];
    self.layer.mask = nil;
    self.layer.contents = nil;
    
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (void)setSerialType:(SerialType)serialType{
    
    _serialType = serialType;
    if (_serialType == SerialTypeNormal) {
        [self addLineForLayer];
    }else if(_serialType == SerialTypeTop){
        [self addArrowForlayer];
    }
}

- (void)setToBeSpecialViewWithSerialType:(SerialType)serialType{
    _isSpecial = YES;
    _serialType = serialType;
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
}

- (void)addLineForLayer{
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    _lineLayer.frame = CGRectMake(0, 0, 2, CGRectGetHeight(self.frame));
    _lineLayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    _lineLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_lineLayer];
    
    [_graphLayer removeFromSuperlayer];
}

- (void)addArrowForlayer{
    if (!_graphLayer) {
        _graphLayer = [CALayer layer];
    }
    _graphLayer.frame = CGRectMake(0, 0, 20, 20);
    _graphLayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, 10);
    _graphLayer.cornerRadius = 10;
    _graphLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_graphLayer];
    
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    _lineLayer.frame = CGRectMake(0, 0, 2, CGRectGetHeight(self.frame));
    _lineLayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    _lineLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_lineLayer];
}

- (BOOL)isSpecialView{
    return _isSpecial;
}

#pragma mark - click event

- (void)buttonPressedEventIsSerial:(SerialType)serialType{
    _serialType = serialType;
    
    if (_clicked) {
        return;
    }
    _clicked = YES;
    
    if (!self.isSpecial) {
        [self failAnimation];
        if ([_gameDelegate respondsToSelector:@selector(gameFail)]) {
            [_gameDelegate gameFail];
        }
    }else{
        
        if (!_serialType) {
            [self startCellAnimation:[UIColor whiteColor] removeAnimateLayer:NO];
        }
        if ([_gameDelegate respondsToSelector:@selector(gameSceneCellDidSelectedRightCell:)]) {
            [_gameDelegate gameSceneCellDidSelectedRightCell:self];
        }
        
        self.isSpecial = NO;
    }
}

#pragma mark - game animation

- (void)startCellAnimation:(UIColor *)layerColor removeAnimateLayer:(BOOL)removeAniLayer{
    [self bezierPathAnimation:layerColor removeAnimateLayer:(BOOL)removeAniLayer];
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

- (void)bezierPathAnimation:(UIColor *)shapeLayerColor removeAnimateLayer:(BOOL)removeAniLayer{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = shapeLayerColor.CGColor;
        _shapeLayer.lineWidth = 0.0;
        _shapeLayer.fillColor = shapeLayerColor.CGColor;
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
    //removedOnCompletion and kCAFillModeForwards keep the final animation state
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.5;
    animation.beginTime = CACurrentMediaTime();
    if (removeAniLayer) {
        animation.delegate = self;
    }
    
    [_shapeLayer addAnimation:animation forKey:@"transformAnimation"];
}

- (void)failAnimation{
    __block int circleTimes = 0;
    WeakSelf;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        if (circleTimes % 2) {
            weakSelf.backgroundColor = [UIColor whiteColor];
        }else{
            weakSelf.backgroundColor = [UIColor redColor];
        }
        
        circleTimes++;
        if (circleTimes > 4) {
            dispatch_cancel(weakSelf.timer);
        }
    });
    dispatch_resume(_timer);
}

- (void)redrawSublayerWithTouchPosition:(CGPoint)point{
    
    if (!_dynamicShapeLayer) {
        _dynamicShapeLayer = [CAShapeLayer layer];
        _dynamicShapeLayer.frame = CGRectMake(0, -40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + 40);
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint headPoint = CGPointMake(CGRectGetWidth(_dynamicShapeLayer.frame)/2,point.y - 40);
    CGPoint leftTop = CGPointMake(0, point.y - 20);
    CGPoint rightTop = CGPointMake(CGRectGetWidth(_dynamicShapeLayer.frame), point.y - 20);
    CGPoint leftBottom = CGPointMake(0, CGRectGetHeight(_dynamicShapeLayer.frame));
    CGPoint rightBottom = CGPointMake(CGRectGetWidth(_dynamicShapeLayer.frame), CGRectGetHeight(_dynamicShapeLayer.frame));
    
    [bezierPath moveToPoint:leftBottom];
    [bezierPath addLineToPoint:leftTop];
    [bezierPath addQuadCurveToPoint:rightTop controlPoint:headPoint];
    [bezierPath addLineToPoint:rightBottom];
    [bezierPath addLineToPoint:leftBottom];
    
    [self.layer addSublayer:_dynamicShapeLayer];
    self.layer.masksToBounds = NO;
    _dynamicShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _dynamicShapeLayer.path = bezierPath.CGPath;
}

#pragma mark - CAAnimation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
    self.layer.contents = nil;
}

@end
