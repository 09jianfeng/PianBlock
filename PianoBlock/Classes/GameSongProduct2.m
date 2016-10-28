//
//  GameSongProduct2.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongProduct2.h"

static NSString * const filePath = @"resource2/song/Happy New Year.json";

@interface GameSongProduct2()

@end

@implementation GameSongProduct2{
    NSMutableArray *_musicBeatDataAry;
    NSInteger _beatIndex;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *mainPath = [[NSBundle mainBundle] resourcePath];
        NSString *songPath = [mainPath stringByAppendingPathComponent:filePath];
        NSData *fileData = [NSData dataWithContentsOfFile:songPath];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"jsonDic %@",jsonDic);
    }
    return self;
}



- (void)playNextBeat{
    
}

- (void)cacheAudio{
    
}

- (void)playWholSongWithBeats:(int)timeInterval{
    
}

@end
