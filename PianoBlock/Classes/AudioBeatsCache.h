//
//  AudioBeatsCache.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/11/21.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioBeatsCache : NSObject

+ (instancetype)shareInstance;

- (NSData *)beatDataByName:(NSString *)beatName;

@end
