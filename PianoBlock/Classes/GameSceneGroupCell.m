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
//cells in per line
@property(nonatomic, strong) NSMutableArray *unitCells;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, assign) NSInteger colorfulIndex;

@property(nonatomic, assign) NSInteger blockWidth;
@property(nonatomic, assign) NSInteger blockHeigh;

@end

@implementation GameSceneGroupCell

- (instancetype)initWithUnitCellsNum:(NSInteger)blockNums
                               frame:(CGRect)frame
                     randomColorsNum:(NSInteger)randomColorsNum{
    
    self = [super initWithFrame:frame];
    if (self) {
        _blockWidth = frame.size.width / blockNums;
        _blockHeigh = frame.size.height;
        _unitCells = [[NSMutableArray alloc] initWithCapacity:blockNums];
        
        NSMutableArray *randIndexs = [[NSMutableArray alloc] initWithCapacity:blockNums];
        for (NSInteger i = 0 ; i < randomColorsNum ; i++) {
            int randomIndex = arc4random() % blockNums;
            [randIndexs addObject:[NSNumber numberWithInt:randomIndex]];
        }
        for (int i = 0; i < blockNums ; i++) {
            GameSceneGroupCellUnitView *unit = [[GameSceneGroupCellUnitView alloc] initWithFrame:CGRectMake(_blockWidth * i, 0 , _blockWidth, _blockHeigh)];
            unit.layer.borderColor = [UIColor grayColor].CGColor;
            unit.layer.borderWidth = 1.0;
            
            [self addSubview:unit];
            [_unitCells addObject:unit];
            if ([randIndexs containsObject:[NSNumber numberWithInt:i]]) {
                [unit setToBeSpecialView];
            }
        }
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

@end
