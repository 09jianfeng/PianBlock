//
//  GameSceneGroupCell.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSceneGroupCell.h"
#import "GameSceneGroupCellUnitView.h"

@interface GameSceneGroupCell()
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, assign) NSInteger colorfulIndex;

@property(nonatomic, assign) NSInteger blockWidth;
@property(nonatomic, assign) NSInteger blockHeigh;
@property(nonatomic, assign) NSInteger blockNum;

@end

@implementation GameSceneGroupCell

- (instancetype)initWithUnitCellsNum:(NSInteger)blockNums
                               frame:(CGRect)frame
                     randomColorsNum:(NSInteger)randomColorsNum{
    
    self = [super initWithFrame:frame];
    if (self) {
        _blockNum = blockNums;
        _blockWidth = frame.size.width / blockNums;
        _blockHeigh = frame.size.height;
        _unitCells = [[NSMutableArray alloc] initWithCapacity:blockNums];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithUnitCellsNum:4 frame:CGRectZero randomColorsNum:1];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (int)loadSubCells{
    
    int randomIndex = arc4random() % _blockNum;
    for (int i = 0; i < _blockNum ; i++) {
        BOOL isBlockSpecial = NO;
        if (i == randomIndex) {
            isBlockSpecial = YES;
        }
        
        GameSceneGroupCellUnitView *unit = [[GameSceneGroupCellUnitView alloc] init];
        unit.gameDelegate = _gameDelegate;
        if (isBlockSpecial) {
            [unit setToBeSpecialView];
        }
        if ([_gameDataSource respondsToSelector:@selector(gameScreenGameCellUnit:)]) {
            [_gameDataSource gameScreenGameCellUnit:unit];
        }
        unit.frame = CGRectMake(_blockWidth * i, 0 , _blockWidth, _blockHeigh);
        
        [unit loadSubview];
        [self addSubview:unit];
        [_unitCells addObject:unit];
    }
    
    return randomIndex;
}

- (int)reuseSubCells{
    
    int randomIndex = arc4random() % _blockNum;
    for (int i = 0 ; i < _unitCells.count ; i++) {
        GameSceneGroupCellUnitView *unit = _unitCells[i];
        if ([unit isSpecialView]) {
            if ([_gameDelegate respondsToSelector:@selector(gameFail)]) {
                [_gameDelegate gameFail];
            }
        }
        [unit reuseUnitView];
        
        BOOL isSpecial = NO;
        if (i == randomIndex) {
            isSpecial = YES;
        }
        
        if (isSpecial) {
            [unit setToBeSpecialView];
        }
        if ([_gameDataSource respondsToSelector:@selector(gameScreenGameCellUnit:)]) {
            [_gameDataSource gameScreenGameCellUnit:unit];
        }
    }
    
    return randomIndex;
}

- (BOOL)isHaveSpecialUnitView{
    BOOL isContainSpecialUnitView = NO;
    for (GameSceneGroupCellUnitView *unit in _unitCells) {
        if ([unit isSpecialView]) {
            isContainSpecialUnitView = YES;
        }
    }
    
    return isContainSpecialUnitView;
}

@end
