//
//  GameSceneView.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneView.h"
#import "GameSceneGroupCell.h"

@interface GameSceneView()

@property (nonatomic, strong) UIView *viewGroupForOneLine;
@property (nonatomic, strong) NSMutableArray *groupCellPool;

@property (nonatomic, assign) NSInteger blockNumPerGroupCell;
@property (nonatomic, assign) CGFloat blockHeigh;
@property (nonatomic, assign) CGFloat blockWidth;
@property (nonatomic, assign) NSInteger groupCellsNum;

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

- (void)gameBegin{
    
}



@end
