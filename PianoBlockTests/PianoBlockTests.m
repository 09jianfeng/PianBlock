//
//  PianoBlockTests.m
//  PianoBlockTests
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameBeatSongDirector.h"
#import "GameBeatSongBuilder.h"

#define WAIT                                                                \
do {                                                                        \
[self expectationForNotification:@"YMDUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil];                   \
} while(0);

#define NOTIFY                                                                            \
do {                                                                                      \
[[NSNotificationCenter defaultCenter] postNotificationName:@"YMDUnitTest" object:nil]; \
} while(0);


@interface PianoBlockTests : XCTestCase

@end

@implementation PianoBlockTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSongList {
    GameBeatSongDirector *director = [GameBeatSongDirector new];
    NSArray *songList = [director gameMusicList];
    for (GameBeatSongBuilder *builder in songList) {
        NSLog(@"buildeder desc %@", [builder description]);
    }
    
    XCTAssertNotNil(songList);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
