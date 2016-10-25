//
//  GameSceneView.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneView.h"
#import "GameSceneGroupCell.h"
#import "GameMacro.h"
#import "GameSceneGroupCellUnitView.h"
#import "GameCountdownWindow.h"

#define GameSpeedNonAutoRoll _blockHeigh / 20
#define GameSpeedAutoRollRimit _blockHeigh / 20
#define GameSpeedIncrementPerInterval 0.2
#define GameSpeedIncrementInterval 0.2

#define CharListLength 20
#define BlockNumPerLine 4

@interface GameSceneView() <GameSceneViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) UIView *viewGroupForOneLine;
@property (nonatomic, strong) NSMutableArray *groupCellPool;

@property (nonatomic, assign) CGFloat blockHeigh;
@property (nonatomic, assign) CGFloat blockWidth;
@property (nonatomic, assign) NSInteger cellLineNum;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@end

@implementation GameSceneView{
    dispatch_source_t _timer;
    UIGestureRecognizer *_gesture;
    CGPoint _touchingPoint;
    // 连击模式的时候用，因为用这个view派发点击事件，当滚动过快的时候。来不及收手，会点到上面那一块。为了避免这个问题
    BOOL _isHaveClickRightBlockBefor;
    char *_specialBlocks;
    char *_serialType;
}

#pragma mark - game scene init

- (void)dealloc{
    
    NSLog(@"GameSceneView dealloc");
    
    free(_specialBlocks);
    free(_serialType);
}

- (instancetype)initWithBlockNumPerLine:(NSInteger)blockNum
                                  frame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _blockWidth = frame.size.width / BlockNumPerLine;
        _blockHeigh = _blockWidth * 1.5;
        _cellLineNum = ceil(frame.size.height / _blockHeigh) + 1;
        _gameSpeed = 2.0;
        _groupCellPool = [[NSMutableArray alloc] initWithCapacity:_cellLineNum];
        
        _serialType = malloc(sizeof(char)*CharListLength);
        memset(_serialType, 0, CharListLength);
        
        _specialBlocks = malloc(sizeof(char) * CharListLength);
        memset(_specialBlocks, -1, CharListLength);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithBlockNumPerLine:BlockNumPerLine frame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if (self) {
    }
    return self;
}

- (void)loadSubView{
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        //从最后的cellGroup往上一个一个add
        GameSceneGroupCell *groupCell = [[GameSceneGroupCell alloc]
                                         initWithUnitCellsNum:BlockNumPerLine
                                         frame:CGRectMake(0, self.frame.size.height - _blockHeigh * (i+1), self.frame.size.width, _blockHeigh)
                                         randomColorsNum:1];
        groupCell.gameDelegate = self;
        [_groupCellPool addObject:groupCell];
        
        int randomIndex = arc4random() % BlockNumPerLine;
        NSInteger lineIndex = _cellLineNum - i - 1;
        [self checkserialType:randomIndex inLine:lineIndex poolIndex:i];
        [groupCell loadSubCells:randomIndex serialType:[self getBlockSerialTypeByIndex:lineIndex]];
        
        [self insertSubview:groupCell atIndex:0];
    }
}

#pragma mark - 检查是否是连续的block
- (void)checkserialType:(NSInteger)index inLine:(NSInteger)line poolIndex:(NSInteger)poolIndex{
    _specialBlocks[line] = index;
    
    NSInteger upLine = line +1;
    NSInteger downLine = line - 1;
    
    if (upLine < _cellLineNum && _specialBlocks[upLine] == index) {
        _serialType[line] = SerialTypeTop;
        _serialType[upLine] = SerialTypeNormal;
        
        [_groupCellPool[poolIndex] updateSpecialUnitViewSerialType:SerialTypeTop];
        [_groupCellPool[poolIndex - 1] updateSpecialUnitViewSerialType:SerialTypeNormal];
    }
    
    if (downLine >= 0 && _specialBlocks[downLine] == index) {
        _serialType[line] = SerialTypeNormal;
        _serialType[downLine] = SerialTypeTop;
        
        [_groupCellPool[poolIndex] updateSpecialUnitViewSerialType:SerialTypeNormal];
    }
}

- (SerialType)getBlockSerialTypeByIndex:(NSInteger)index{
    return _serialType[index];
}

- (void)charMoveDown:(char *)charList length:(NSInteger)length{
    for (NSInteger i = length - 2; i >= 0; i--) {
        charList[i + 1] = charList[i];
    }
}

#pragma mark - game handle

- (void)stop{
    [self.displayLink setPaused:YES];
}

- (void)contine{
    WeakSelf;
    [[GameCountdownWindow shareInstance] showWithAnimNum:1 CompleteBlock:^{
        [weakSelf.displayLink setPaused:NO];
    }];
}

#pragma mark - scroll animation

- (void)startGame{
    if (_gameMode != GAMEMODE_MANUALROLL) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginRoll)];
        
        WeakSelf;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, GameSpeedIncrementInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            weakSelf.gameSpeed += GameSpeedIncrementPerInterval;
            
            if (weakSelf.gameSpeed > GameSpeedAutoRollRimit) {
                weakSelf.gameSpeed = GameSpeedAutoRollRimit;
            }
        });
        dispatch_resume(_timer);
    }else{
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rollOneCell)];
        self.gameSpeed = GameSpeedNonAutoRoll;
        if (self.gameSpeed > GameSpeedAutoRollRimit) {
            self.gameSpeed = GameSpeedAutoRollRimit;
        }

        [self stop];
    }
    
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

// auto roll displayLink cycle
- (void)beginRoll{
    
    WeakSelf;
    // 检查是否超出屏幕，超出的部分重用
    [self.groupCellPool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GameSceneGroupCell *groupCell = (GameSceneGroupCell *)obj;
        CGRect cellFrame = groupCell.frame;
        cellFrame.origin.y += weakSelf.gameSpeed;
        groupCell.frame = cellFrame;
        
        // 重用超出范围的 group cell
        if (cellFrame.origin.y > weakSelf.frame.size.height) {
            GameSceneGroupCell *lastCell = [weakSelf.groupCellPool lastObject];
            [weakSelf.groupCellPool removeObject:groupCell];
            cellFrame.origin.y = lastCell.frame.origin.y - cellFrame.size.height + weakSelf.gameSpeed;
            groupCell.frame = cellFrame;
            [weakSelf.groupCellPool addObject:groupCell];
            [groupCell removeFromSuperview];
            [self insertSubview:groupCell atIndex:0];
            
            // 检查 reuse的那个cell是否有跟上下的block连续
            [self charMoveDown:_serialType length:CharListLength];
            _serialType[0] = 0;
            [self charMoveDown:_specialBlocks length:CharListLength];
            _specialBlocks[0] = -1;
            int randomIndex = arc4random() % BlockNumPerLine;
            [self checkserialType:randomIndex inLine:0 poolIndex:_groupCellPool.count - 1];
            [groupCell reuseSubCells:randomIndex serialType:[self getBlockSerialTypeByIndex:0]];
        }
    }];
    
    //手指抬起来了后也不往下调用 如果是模式不允许连击，就不用连击
    if (CGPointEqualToPoint(_touchingPoint, CGPointZero) || _gameMode != GAMEMODE_AUTOROLLMUTLCLICK) {
        return;
    }
    
    //点击事件传递
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        GameSceneGroupCell *cell = _groupCellPool[i];
        CGPoint unitViewPoint = [self convertPoint:_touchingPoint toView:cell];
        if ([cell pointInside:unitViewPoint withEvent:nil]) {
            SerialType serialType = [self getBlockSerialTypeByIndex:_cellLineNum - i -1];
            _isHaveClickRightBlockBefor = [cell toucheInPoint:unitViewPoint isHaveClickRightBlockBefor:_isHaveClickRightBlockBefor serialType:serialType];
        }
    }
}


// not auto roll
- (void)rollOneCell{
    
    WeakSelf;
    for (GameSceneGroupCell *groupCell in self.groupCellPool) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect cellFrame = groupCell.frame;
            cellFrame.origin.y += weakSelf.gameSpeed;
            groupCell.frame = cellFrame;
            
            if (cellFrame.origin.y + cellFrame.size.height >= weakSelf.frame.size.height) {
                BOOL isContainSpecialUnitView = [groupCell isHaveSpecialUnitView];
                if (isContainSpecialUnitView) {
                    [self stop];
                }
            }
            
            if (cellFrame.origin.y > weakSelf.frame.size.height) {
                GameSceneGroupCell *lastCell = [weakSelf.groupCellPool lastObject];
                [weakSelf.groupCellPool removeObject:groupCell];
                cellFrame.origin.y = lastCell.frame.origin.y - cellFrame.size.height + weakSelf.gameSpeed;
                groupCell.frame = cellFrame;
                int randomIndex = arc4random() % BlockNumPerLine;
                [groupCell reuseSubCells:randomIndex serialType:SerialTypeNotSerial];
                [weakSelf.groupCellPool addObject:groupCell];
                [groupCell removeFromSuperview];
                [self insertSubview:groupCell atIndex:0];
            }
        });
    }
}


#pragma mark - gameSceneViewDelegate
- (void)gameSceneCellDidSelectedRightCell:(GameSceneGroupCellUnitView *)gameUnit{
    if (_gameDelegate) {
        [_gameDelegate gameSceneCellDidSelectedRightCell:gameUnit];
    }
    
    //  如果是手动滚动的方式才需要continue， 因为手动的动画有时候会被stop。
    if (_gameMode != GAMEMODE_MANUALROLL || !gameUnit.isSpecial) {
        return;
    }
    
    [self contine];
}

- (void)gameFail{
    if (_gameDelegate) {
        [_gameDelegate gameFail];
    }
    
    [self stop];
}

#pragma mark - touch event catch
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isHaveClickRightBlockBefor = NO;
    
    NSEnumerator *enumerator = [touches objectEnumerator];
    UITouch *toucher = enumerator.nextObject;
    CGPoint location = [toucher locationInView:self];
    _touchingPoint = location;
    
    //点击事件传递
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        GameSceneGroupCell *cell = _groupCellPool[i];
        CGPoint unitViewPoint = [self convertPoint:_touchingPoint toView:cell];
        if ([cell pointInside:unitViewPoint withEvent:nil]) {
            SerialType serialType = [self getBlockSerialTypeByIndex:_cellLineNum - i -1];
            _isHaveClickRightBlockBefor = [cell toucheInPoint:unitViewPoint isHaveClickRightBlockBefor:_isHaveClickRightBlockBefor serialType:serialType];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSEnumerator *enumerator = [touches objectEnumerator];
    UITouch *toucher = enumerator.nextObject;
    CGPoint location = [toucher locationInView:self];
    _touchingPoint = location;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    _touchingPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
}

#pragma mark - 点击动画
- (void)waveLayerAnimation:(CALayer *)layer point:(CGPoint)point{
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
    }else{
        [_waveLayer removeAllAnimations];
        [_waveLayer removeFromSuperlayer];
    }
    
    CAKeyframeAnimation *kfAnimateScale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D initTransform = CATransform3DMakeScale(1, 1, 0);
    CATransform3D finalTransform = CATransform3DMakeScale(6, 6, 0);
    kfAnimateScale.values = @[[NSValue valueWithCATransform3D:initTransform],[NSValue valueWithCATransform3D:finalTransform]];
    kfAnimateScale.keyTimes = @[@0,@1];
    kfAnimateScale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    kfAnimateScale.duration = 0.2;
    kfAnimateScale.delegate = self;
    kfAnimateScale.removedOnCompletion = NO;
    kfAnimateScale.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *kfAnimateAlpha = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimateAlpha.values = @[@1.0,@0.0];
    kfAnimateAlpha.keyTimes = @[@0,@1];
    kfAnimateAlpha.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    kfAnimateAlpha.duration = 0.2;
    kfAnimateAlpha.delegate = self;
    kfAnimateAlpha.removedOnCompletion = NO;
    kfAnimateAlpha.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.autoreverses = NO;
    group.duration = 0.2;
    group.animations = @[kfAnimateScale,kfAnimateAlpha];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _waveLayer.backgroundColor = [UIColor clearColor].CGColor;
    _waveLayer.borderColor = [UIColor redColor].CGColor;
    _waveLayer.borderWidth = 6.0;
    _waveLayer.frame = CGRectMake(0, 0, 50, 50);
    _waveLayer.cornerRadius = 25.0;
    _waveLayer.position = point;
    [CATransaction commit];
    
    [layer addSublayer:_waveLayer];
    [_waveLayer addAnimation:group forKey:@"WaveAnimation"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_waveLayer removeAllAnimations];
    [_waveLayer removeFromSuperlayer];
}

@end
