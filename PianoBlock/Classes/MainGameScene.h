//
//  MainGameScene.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/19.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

typedef NS_ENUM(NSInteger,GAMEMAINMANU){
    GAMEMAINMANU_JINDIAN = 5,
    GAMEMAINMANU_LEITING = 6,
    GAMEMAINMANU_SHANBENG = 9,
    GAMEMAINMANU_BAOFENG = 10
};

@interface MainGameScene : UIView

- (instancetype)initWithButtonNumPerLine:(NSInteger)buttonNum
                                  frame:(CGRect)frame __attribute__((objc_designated_initializer));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

- (RACSignal *)gameRACForButtonAtIndex:(GAMEMAINMANU)index;

@end
