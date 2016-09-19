//
//  MainGameScene.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/19.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainGameScene : UIView

- (instancetype)initWithButtonNumPerLine:(NSInteger)buttonNum
                                  frame:(CGRect)frame __attribute__((objc_designated_initializer));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));



@end
