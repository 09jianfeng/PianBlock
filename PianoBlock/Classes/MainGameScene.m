//
//  MainGameScene.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/19.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "MainGameScene.h"
#import "GameSceneGroupCellUnitView.h"

@implementation MainGameScene{
    NSMutableArray *_buttons;
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
        CGFloat buttonWidth = CGRectGetWidth(frame) / buttonNum;
        CGFloat buttonHeigh = buttonWidth * 1.5;
        NSInteger buttonAllNum = ceil(CGRectGetHeight(frame) / buttonHeigh) * buttonNum;
        _buttons = [[NSMutableArray alloc] initWithCapacity:buttonAllNum];
        for (NSInteger i = 0 ; i < buttonAllNum ; i++) {
            GameSceneGroupCellUnitView *button = [GameSceneGroupCellUnitView buttonWithType:UIButtonTypeCustom];
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 1.0;
            button.frame = CGRectMake(buttonWidth * (i % buttonNum), buttonHeigh * (i / buttonNum), buttonWidth, buttonHeigh);
            [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id  _Nullable x) {
                [button startAnimate];
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
    [musicThemeButton setTitle:@"音乐" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *playingThemeButton = [self getButtonByIndex:lastButtonIndex - 1];
    playingThemeButton.backgroundColor = [UIColor blackColor];
    [playingThemeButton setTitle:@"好评" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *rankButton = [self getButtonByIndex:lastButtonIndex - 2];
    rankButton.backgroundColor = [UIColor blackColor];
    [rankButton setTitle:@"排行" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *shareButton = [self getButtonByIndex:lastButtonIndex - 3];
    shareButton.backgroundColor = [UIColor blackColor];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *normalMode = [self getButtonByIndex:GAMEMAINMANU_JINDIAN];
    normalMode.backgroundColor = [UIColor blackColor];
    [normalMode setTitle:@"经典" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *streetMode = [self getButtonByIndex:GAMEMAINMANU_LEITING];
    streetMode.backgroundColor = [UIColor blackColor];
    [streetMode setTitle:@"雷霆" forState:UIControlStateNormal];

    GameSceneGroupCellUnitView *chuangkuai = [self getButtonByIndex:GAMEMAINMANU_SHANBENG];
    chuangkuai.backgroundColor = [UIColor blackColor];
    [chuangkuai setTitle:@"山崩" forState:UIControlStateNormal];
    
    GameSceneGroupCellUnitView *baofeng = [self getButtonByIndex:GAMEMAINMANU_BAOFENG];
    baofeng.backgroundColor = [UIColor blackColor];
    [baofeng setTitle:@"暴风" forState:UIControlStateNormal];
}

- (RACSignal *)gameRACForButtonAtIndex:(GAMEMAINMANU)index{
    GameSceneGroupCellUnitView *unitView = [self getButtonByIndex:index];
    return [unitView rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
