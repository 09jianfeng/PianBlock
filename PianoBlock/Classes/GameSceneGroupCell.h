//
//  GameSceneGroupCell.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSceneGroupCell : UIView

- (instancetype)initWithUnitCellsNum:(NSInteger)blockNums
                               frame:(CGRect)frame
                     randomColorsNum:(NSInteger)randomColorsNum __attribute__((objc_designated_initializer));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((objc_designated_initializer));

@end
