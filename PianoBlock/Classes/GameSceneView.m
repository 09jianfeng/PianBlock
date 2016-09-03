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

@interface GameSceneView()

@property (nonatomic, strong) UIView *viewGroupForOneLine;
@property (nonatomic, strong) NSMutableArray *groupCellPool;

@property (nonatomic, assign) NSInteger blockNumPerGroupCell;
@property (nonatomic, assign) CGFloat blockHeigh;
@property (nonatomic, assign) CGFloat blockWidth;
@property (nonatomic, assign) NSInteger groupCellsNum;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation GameSceneView

#pragma mark - game scene init

- (instancetype)initWithBlockNumPerLine:(NSInteger)blockNum
                                  frame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _blockNumPerGroupCell = blockNum;
        _blockWidth = frame.size.width / blockNum;
        _blockHeigh = _blockWidth * 1.5;
        _groupCellsNum = ceil(frame.size.height / _blockHeigh) + 1;
        _gameSpeed = 2.0;
        _groupCellPool = [[NSMutableArray alloc] initWithCapacity:_groupCellsNum];
        
        for (NSInteger i = 0 ; i < _groupCellsNum ; i++) {
            GameSceneGroupCell *groupCell = [[GameSceneGroupCell alloc] initWithUnitCellsNum:blockNum
                                                                                         frame:CGRectMake(0, frame.size.height - _blockHeigh * (i+1), frame.size.width, _blockHeigh)
                                                                               randomColorsNum:1];
            [self addSubview:groupCell];
            [_groupCellPool addObject:groupCell];
        }
        
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

#pragma mark - game handle

- (void)stop{
    [self.displayLink invalidate];
}

- (void)startGame{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginScroll)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)beginScroll{
    CGFloat weakSpeed = self.gameSpeed;
    NSMutableArray *cellPool = self.groupCellPool;
    [self.groupCellPool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GameSceneGroupCell *groupCell = (GameSceneGroupCell *)obj;
            CGRect cellFrame = groupCell.frame;
            cellFrame.origin.y += weakSpeed;
            groupCell.frame = cellFrame;
            
            if (cellFrame.origin.y > self.frame.size.height) {
                GameSceneGroupCell *lastCell = [cellPool lastObject];
                [cellPool removeObject:groupCell];
                cellFrame.origin.y = lastCell.frame.origin.y - cellFrame.size.height + self.gameSpeed;
                groupCell.frame = cellFrame;
                [groupCell reuseGroupCell];
                [cellPool addObject:groupCell];
            }
        });
    }];
}

@end
