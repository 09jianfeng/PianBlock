//
//  AudioBeatsCache.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/11/21.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "AudioBeatsCache.h"

@implementation AudioBeatsCache{
    NSMutableDictionary *_pianoSoundsDic;
}

+ (instancetype)shareInstance{
    static AudioBeatsCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AudioBeatsCache new];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _pianoSoundsDic = [NSMutableDictionary new];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *pianSoundPath = [self pianoDirectory];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = [fileManager subpathsAtPath:pianSoundPath];
            for (NSString *subFileName in paths) {
                NSString *subFilePath = [pianSoundPath stringByAppendingPathComponent:subFileName];
                NSData *beatsData = [NSData dataWithContentsOfFile:subFilePath];
                [_pianoSoundsDic setObject:beatsData forKey:subFileName];
            }
        });
        
    }
    return self;
}

- (NSData *)beatDataByName:(NSString *)beatName{
    NSData *beatData = _pianoSoundsDic[beatName];
    if (beatData) {
        return beatData;
    }
    
    NSString *pianSoundPath = [self pianoDirectory];
    NSString *soundPath = [pianSoundPath stringByAppendingPathComponent:beatName];
    NSData *beatsData = [NSData dataWithContentsOfFile:soundPath];
    return beatsData;
}

- (NSString *)pianoDirectory{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    resourcePath = [resourcePath stringByAppendingString:@"/resource2/pianoSound"];
    return resourcePath;
}

@end
