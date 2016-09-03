//
//  GameCountdownWindow.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameCountdownWindow.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WeakSelf __weak typeof(self) weakSelf = self

@interface GameCountdownWindow()

@property (nonatomic,strong) UILabel *animLabel;
@property (nonatomic,assign) NSInteger animIndex;
@property (nonatomic,copy) CompleteBlock completeBlock;

@end

@implementation GameCountdownWindow


#pragma mark - 创建单例

static GameCountdownWindow *_instance;

+ (instancetype)shareInstance{
    return [self new];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        _instance.frame = [UIScreen mainScreen].bounds;
        _instance.backgroundColor = [UIColor blackColor];
        _instance.alpha = 0.7;
        _instance.animLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, SCREEN_HEIGHT/2 - 100, 100, 200)];
        _instance.animLabel.textAlignment = NSTextAlignmentCenter;
        _instance.animLabel.textColor = [UIColor whiteColor];
        _instance.animLabel.font = [UIFont systemFontOfSize:120];
        
        [_instance addSubview:_instance.animLabel];
    });
    return _instance;
}

- (id)copy{
    return _instance;
}

- (id)mutableCopy{
    return _instance;
}

#pragma mark - CABasicAnimation

- (CAAnimationGroup *)animationGroup {
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    [animation1 setKeyPath:@"transform.scale"];
    [animation1 setFromValue:@1.0];
    [animation1 setToValue:@0.0];
    [animation1 setDuration:1.0];
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    [animation2 setKeyPath:@"alpha"];
    [animation2 setFromValue:@1.0];
    [animation2 setToValue:@0.3];
    [animation2 setDuration:1.0];
    
    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
    animGroup.animations = [NSArray arrayWithObjects:animation1,animation2, nil];
    [animGroup setDuration:1.0];
    [animGroup setDelegate:self];
    
    //stap animation statue
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = NO;
    
    return animGroup;
}

- (void)startAnimationWithMax:(NSInteger)anim {
    _animLabel.text = [NSString stringWithFormat:@"%ld",(long)anim];

    _animIndex = anim;
    
    [_animLabel.layer addAnimation:[self animationGroup] forKey:nil];
}

- (void)showWithAnimNum:(NSInteger)anim CompleteBlock:(CompleteBlock)completeBlock{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:[GameCountdownWindow shareInstance]];
    [GameCountdownWindow shareInstance].completeBlock = completeBlock;
    [[GameCountdownWindow shareInstance] startAnimationWithMax:anim];
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && _animIndex > 0) {
        _animIndex--;
        _animLabel.text = [NSString stringWithFormat:@"%ld",(long)_animIndex];
        [_animLabel.layer addAnimation:[self animationGroup] forKey:nil];
    }

    if (_animIndex == 0) {
        _animIndex = 100;
        if (_completeBlock != nil) {
            self.hidden = true;
            WeakSelf;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _completeBlock();
                [weakSelf.animLabel.layer removeAllAnimations];
                weakSelf.hidden = false;
                [weakSelf removeFromSuperview];
            });
        }
    }
}

@end
