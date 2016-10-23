//
//  MainGameScene.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/19.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "MainGameScene.h"
#import "GameSceneGroupCellUnitView.h"
#import "Masonry.h"
#import "GameStarButton.h"

@implementation MainGameScene{
    NSMutableArray *_buttons;
    CGFloat _buttonWidth;
    CGFloat _buttonHeigh;
    CGFloat _rowNum;
    GameStarButton *_gameStar;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithButtonNumPerLine:4 frame:frame];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithButtonNumPerLine:(NSInteger)buttonNum
                                  frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonWidth = CGRectGetWidth(frame) / buttonNum;
        _buttonHeigh = _buttonWidth * 1.5;
        _rowNum = buttonNum;
        
        NSInteger buttonAllNum = ceil(CGRectGetHeight(frame) / _buttonHeigh) * buttonNum;
        _buttons = [[NSMutableArray alloc] initWithCapacity:buttonAllNum];
        for (NSInteger i = 0 ; i < buttonAllNum ; i++) {
            GameSceneGroupCellUnitView *button = [GameSceneGroupCellUnitView buttonWithType:UIButtonTypeCustom];
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.frame = CGRectMake(_buttonWidth * (i % buttonNum), _buttonHeigh * (i / buttonNum), _buttonWidth, _buttonHeigh);
            [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id  _Nullable x) {
                [button startAnimate:[UIColor blackColor] removeAnimateLayer:YES];
            }];
            
            [self addSubview:button];
            [_buttons addObject:button];
        }
        
        [self menuSetting];
    }
    return self;
}

- (GameSceneGroupCellUnitView *)getButtonByIndex:(NSInteger)index{
    if (index >= _buttons.count) {
        return nil;
    }
    return _buttons[index];
}

- (void)menuSetting{
    NSInteger lastButtonIndex = _buttons.count - 1;
    GameSceneGroupCellUnitView *musicThemeButton = [self getButtonByIndex:lastButtonIndex];
    musicThemeButton.backgroundColor = [UIColor blackColor];
    [musicThemeButton setTitle:@"更多" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *playingThemeButton = [self getButtonByIndex:lastButtonIndex - 1];
    playingThemeButton.backgroundColor = [UIColor blackColor];
    [playingThemeButton setTitle:@"设置" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *rankButton = [self getButtonByIndex:lastButtonIndex - 2];
    rankButton.backgroundColor = [UIColor blackColor];
    [rankButton setTitle:@"钢琴曲" forState:UIControlStateNormal];
    
    
    GameSceneGroupCellUnitView *shareButton = [self getButtonByIndex:lastButtonIndex - 3];
    shareButton.backgroundColor = [UIColor blackColor];
    [shareButton setTitle:@"我的" forState:UIControlStateNormal];
        
    _gameStar = [GameStarButton buttonWithType:UIButtonTypeCustom];
    _gameStar.backgroundColor = [UIColor blackColor];
    CGFloat centYOffset = [self getBeginBtnCentYOffser];
    CGFloat blockWidth = _buttonWidth;
    [_gameStar setTitle:@"开始" forState:UIControlStateNormal];
    [_gameStar setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _gameStar.layer.cornerRadius = blockWidth / 2;
    _gameStar.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    _gameStar.layer.shadowOpacity = 0.5;
    _gameStar.layer.shadowColor = [UIColor redColor].CGColor;
    [self addSubview:_gameStar];
    
    [_gameStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(blockWidth);
        make.height.mas_equalTo(blockWidth);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(centYOffset);
    }];
}

- (CGFloat)getBeginBtnCentYOffser{
    NSInteger blockAllNum = _buttons.count;
    NSInteger blockLineNum =blockAllNum / _rowNum;
    
    CGFloat centY = (blockLineNum - 1) * _buttonHeigh / 2;
    
    return centY - CGRectGetHeight(self.frame)/2;
}

- (void)beginMainSceneAnimation{
    [_gameStar beginAnimations];
}

- (void)stopMainSceneAnimation{
    [_gameStar stopAnimations];
}

#pragma mark - buttonCommand bind

- (RACSignal *)gameStarButonCommandBind:(RACCommand *)raccommand{
    _gameStar.rac_command = raccommand;
    return _gameStar.rac_command.executionSignals;
}


- (RACSignal *)gameRACForButtonAtIndex:(GAMEMAINMANU)index bindCommand:(RACCommand *)raccommand{
    GameSceneGroupCellUnitView *unitView = [self getButtonByIndex:index];
    unitView.rac_command = raccommand;
    return unitView.rac_command.executionSignals;
}

@end
