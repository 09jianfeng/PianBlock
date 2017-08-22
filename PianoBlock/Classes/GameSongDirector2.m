//
//  GameSongDirector2.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameSongDirector2.h"
#import "GameSongBuilder2.h"
#import "GameSongProduct2.h"
#import "CHCSVParser.h"
#import "GameMacro.h"

static NSString * const GameSongListFileName = @"resource2/DB/songBasicInfo.csv";

@interface GameSongDirector2()<CHCSVParserDelegate>
@property (nonatomic, copy) void (^csvParseFinishBlock)(NSArray<id<AFSongProductDelegate>> *list);
@property (nonatomic, strong) CHCSVParser *csvParser;
@end

@implementation GameSongDirector2 {
    NSMutableArray<GameSongProduct2 *> *_gameMusicList;
}

- (void)dealloc{
    NSLog(@"GameSongDirector2 dealloc");
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _gameMusicList = [NSMutableArray new];
    }
    return self;
}

- (void)gameMusicList:(void (^)(NSArray<id<AFSongProductDelegate>> *list))completeBlock{
    self.csvParseFinishBlock = completeBlock;
    
    NSString *songListPath = [self getMusicListPath];
    _csvParser = [[CHCSVParser alloc] initWithContentsOfDelimitedURL:[NSURL fileURLWithPath:songListPath] delimiter:'@'];
    _csvParser.delegate = self;
    _csvParser.recognizesComments = YES;
    [_csvParser parse];
}

- (NSString *)getMusicListPath{
    NSString *mainPath = [[NSBundle mainBundle] bundlePath];
    
    return  [mainPath stringByAppendingPathComponent:GameSongListFileName];
}


#pragma mark - GameSongListFileName
/**
 *  Indicates that the parser has started parsing the stream
 *
 *  @param parser The @c CHCSVParser instance
 */
- (void)parserDidBeginDocument:(CHCSVParser *)parser{
    NSLog(@"parserDidBeginDocument ");
}

/**
 *  Indicates that the parser has successfully finished parsing the stream
 *
 *  This method is not invoked if any error is encountered
 *
 *  @param parser The @c CHCSVParser instance
 */
- (void)parserDidEndDocument:(CHCSVParser *)parser{
    NSLog(@"parserDidEndDocument");
    _csvParseFinishBlock(_gameMusicList);
}

/**
 *  Indicates the parser has started parsing a line
 *
 *  @param parser       The @c CHCSVParser instance
 *  @param recordNumber The 1-based number of the record
 */
- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber{
    NSLog(@"parser didBeginLine line:%td",recordNumber);
}

/**
 *  Indicates the parser has finished parsing a line
 *
 *  @param parser       The @c CHCSVParser instance
 *  @param recordNumber The 1-based number of the record
 */
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber{
    NSLog(@"parser didEndLine line:%td",recordNumber);
}

/**
 *  Indicates the parser has parsed a field on the current line
 *
 *  @param parser     The @c CHCSVParser instance
 *  @param field      The parsed string. If configured to do so, this string may be sanitized and trimmed
 *  @param fieldIndex The 0-based index of the field within the current record
 */
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex{
    if (fieldIndex == 0) {
        NSArray *values = [field componentsSeparatedByString:@";"];
        GameSongProduct2 *song = [[GameSongProduct2 alloc] initWithValues:values];
        [_gameMusicList addObject:song];
    }
}

/**
 *  Indicates the parser has encountered a comment
 *
 *  This method is only invoked if @c CHCSVParser.recognizesComments is @c YES
 *
 *  @param parser  The @c CHCSVParser instance
 *  @param comment The parsed comment
 */
- (void)parser:(CHCSVParser *)parser didReadComment:(NSString *)comment{
    NSLog(@"didReadComment %@",comment);
}

/**
 *  Indicates the parser encounter an error while parsing
 *
 *  @param parser The @c CHCSVParser instance
 *  @param error  The @c NSError instance
 */
- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error{
    NSLog(@"parser didiFailWithError");
}


@end
