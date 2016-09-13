//
//  ProductGameModeStruct.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/13.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductGameModeStruct : NSObject

//wether timeLimit
@property(nonatomic, assign) BOOL isTimeLimit;
@property(nonatomic, assign) NSInteger timeInterval;
@property(nonatomic, assign) BOOL isScoresLimit;
@property(nonatomic, assign) NSInteger scoresTarget;
@property(nonatomic, assign) NSInteger gameCurrentScores;
@property(nonatomic, assign) NSInteger gameBestScores;

@end
