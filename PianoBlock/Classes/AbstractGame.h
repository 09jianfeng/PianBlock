//
//  AbstractGame.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GameDataSourceClass id<AbstractGame>

@protocol AbstractGame <NSObject>

@required
- (NSArray *)AG_gameDataSource;

@end
