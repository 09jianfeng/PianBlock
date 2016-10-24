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
#define GameSpeedAutoRollRimit _blockHeigh / 10
#define GameSpeedIncrementPerInterval 0.2
#define GameSpeedIncrementInterval 0.2

@interface GameSceneView() <GameSceneViewDelegate>

@property (nonatomic, strong) UIView *viewGroupForOneLine;
@property (nonatomic, strong) NSMutableArray *groupCellPool;

@property (nonatomic, assign) NSInteger blockNumPerGroupCell;
@property (nonatomic, assign) CGFloat blockHeigh;
@property (nonatomic, assign) CGFloat blockWidth;
@property (nonatomic, assign) NSInteger cellLineNum;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) char *specialBlocks;
@property (nonatomic, assign) char *isSerial;

@end

@implementation GameSceneView{
    dispatch_source_t _timer;
    UIGestureRecognizer *_gesture;
    CGPoint _touchingPoint;
    // 连击模式的时候用，因为用这个view派发点击事件，当滚动过快的时候。来不及收手，会点到上面那一块。为了避免这个问题
    BOOL _isHaveClickRightFirstBlock;
}

#pragma mark - game scene init

- (void)dealloc{
    free(_isSerial);
}

- (instancetype)initWithBlockNumPerLine:(NSInteger)blockNum
                                  frame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _blockNumPerGroupCell = blockNum;
        
        if ([_gameDataSource respondsToSelector:@selector(gameSceneUnitNumPerCell)]) {
            _blockNumPerGroupCell = [_gameDataSource gameSceneUnitNumPerCell];
        }
        
        _blockWidth = frame.size.width / blockNum;
        _blockHeigh = _blockWidth * 1.5;
        _cellLineNum = ceil(frame.size.height / _blockHeigh) + 1;
        _gameSpeed = 2.0;
        _groupCellPool = [[NSMutableArray alloc] initWithCapacity:_cellLineNum];
        
        _isSerial = malloc(sizeof(char)*20);
        memset(_isSerial, 0, 20);
        
        _specialBlocks = malloc(sizeof(char) * 20);
        memset(_specialBlocks, -1, 20);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithBlockNumPerLine:4 frame:frame];
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

- (void)setBlockNumPerGroupCell:(NSInteger)blockNum{
    _blockNumPerGroupCell = blockNum;
    _blockWidth = self.frame.size.width / blockNum;
    _blockHeigh = _blockWidth * 1.5;
    _cellLineNum = ceil(self.frame.size.height / _blockHeigh) + 1;
    _groupCellPool = [[NSMutableArray alloc] initWithCapacity:_cellLineNum];
}

- (void)loadSubView{
    if ([_gameDataSource respondsToSelector:@selector(gameSceneUnitNumPerCell)]) {
        self.blockNumPerGroupCell = [_gameDataSource gameSceneUnitNumPerCell];
    }
    
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        //从最后的cellGroup往上一个一个add
        GameSceneGroupCell *groupCell = [[GameSceneGroupCell alloc]
                                         initWithUnitCellsNum:_blockNumPerGroupCell
                                         frame:CGRectMake(0, self.frame.size.height - _blockHeigh * (i+1), self.frame.size.width, _blockHeigh)
                                         randomColorsNum:1];
        groupCell.gameDataSource = _gameDataSource;
        groupCell.gameDelegate = self;
        int specialCellIndex = [groupCell loadSubCells];
        [self checkIsSerial:specialCellIndex inLine:_cellLineNum - i];
        
        [self addSubview:groupCell];
        [_groupCellPool addObject:groupCell];
    }
}

#pragma mark - 检查是否是连续的block

- (void)checkIsSerial:(NSInteger)index inLine:(NSInteger)line{
    _specialBlocks[line] = index;
    
    NSInteger upIndex = index +1;
    NSInteger downIndex = index - 1;
    
    if (upIndex < _cellLineNum && _specialBlocks[upIndex] == index) {
        _isSerial[line] = 1;
        _isSerial[upIndex] = 1;
    }
    
    if (downIndex >= 0 && _specialBlocks[downIndex] == index) {
        _isSerial[line] = 1;
        _isSerial[downIndex] = 1;
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

// auto roll
- (void)beginRoll{
    
    WeakSelf;
    [self.groupCellPool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GameSceneGroupCell *groupCell = (GameSceneGroupCell *)obj;
        CGRect cellFrame = groupCell.frame;
        cellFrame.origin.y += weakSelf.gameSpeed;
        groupCell.frame = cellFrame;
        
        if (cellFrame.origin.y > weakSelf.frame.size.height) {
            GameSceneGroupCell *lastCell = [weakSelf.groupCellPool lastObject];
            [weakSelf.groupCellPool removeObject:groupCell];
            cellFrame.origin.y = lastCell.frame.origin.y - cellFrame.size.height + weakSelf.gameSpeed;
            groupCell.frame = cellFrame;
            [weakSelf.groupCellPool addObject:groupCell];
            
            // 检查 reuse的那个cell是否有跟上下的block连续
            _isSerial[_cellLineNum] = 0;
            _specialBlocks[_cellLineNum] = -1;
            NSInteger specialIndex = [groupCell reuseSubCells];
            [self checkIsSerial:specialIndex inLine:0];
        }
    }];
    
    //如果是模式不允许连击，就不用连击
    if (CGPointEqualToPoint(_touchingPoint, CGPointZero) || _gameMode != GAMEMODE_AUTOROLLMUTLCLICK) {
        return;
    }
    
    //连击判断
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        GameSceneGroupCell *cell = _groupCellPool[i];
        
        NSArray *unitViews = [cell unitCells];
        for (GameSceneGroupCellUnitView *unitView in unitViews) {
            CGPoint unitViewPoint = [self convertPoint:_touchingPoint toView:unitView];
            if ([unitView pointInside:unitViewPoint withEvent:nil]) {
                
                //手指还没收起来的时候，触摸点到了非 special区域的点击事件，拦下来。
                if (!unitView.isSpecialView && _isHaveClickRightFirstBlock) {
                    NSLog(@"点击事件被拦");
                    [unitView redrawSublayerWithTouchPosition:unitViewPoint];
                }else{
                    if (unitView.isSpecialView) {
                        _isHaveClickRightFirstBlock = YES;
                    }
                    
                    BOOL isSerial = _isSerial[i];
                    [unitView buttonPressedEventIsSerial:isSerial];
                    NSLog(@"-----------button is serial %d",isSerial);
                    if (isSerial) {
                        [unitView redrawSublayerWithTouchPosition:unitViewPoint];
                    }
                }
            }
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
                [groupCell reuseSubCells];
                [weakSelf.groupCellPool addObject:groupCell];
            }
        });
    }
}


#pragma mark - gameSceneViewDelegate
- (void)gameSceneCellBlockDidSelectedInblock:(BOOL)isSpecialBlock gameUnit:(GameSceneGroupCellUnitView *)gameUnit{
    if (_gameDelegate) {
        [_gameDelegate gameSceneCellBlockDidSelectedInblock:isSpecialBlock gameUnit:gameUnit];
    }
    
    //  如果是手动滚动的方式才需要continue， 因为手动的动画有时候会被stop。
    if (_gameMode != GAMEMODE_MANUALROLL || !isSpecialBlock) {
        return;
    }
    
    [self contine];
}

- (void)gameFail{
    if (_gameDelegate) {
        [_gameDelegate gameFail];
    }
}

#pragma mark - touch event catch
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isHaveClickRightFirstBlock = NO;
    
    NSEnumerator *enumerator = [touches objectEnumerator];
    UITouch *toucher = enumerator.nextObject;
    CGPoint location = [toucher locationInView:self];
    _touchingPoint = location;
    
    for (NSInteger i = 0 ; i < _cellLineNum ; i++) {
        GameSceneGroupCell *cell = _groupCellPool[i];
        NSArray *unitViews = [cell unitCells];
        for (GameSceneGroupCellUnitView *unitView in unitViews) {
            CGPoint unitViewPoint = [self convertPoint:_touchingPoint toView:unitView];
            if ([unitView pointInside:unitViewPoint withEvent:nil]) {
                if (unitView.isSpecialView) {
                    _isHaveClickRightFirstBlock = YES;
                }
                
                BOOL isSerial = _isSerial[i];
                [unitView buttonPressedEventIsSerial:isSerial];
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    _touchingPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
}

@end
