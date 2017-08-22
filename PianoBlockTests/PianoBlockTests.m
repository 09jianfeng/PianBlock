//
//  PianoBlockTests.m
//  PianoBlockTests
//
//  Created by 陈建峰 on 16/9/1.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameSongDirector.h"
#import "GameSongBuilder.h"
#import "GameSongProduct.h"
#import "Header.h"

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
    GameSongDirector *director = [GameSongDirector new];
    [director gameMusicList:^(NSArray<id<AFSongProductDelegate>> *list) {
        for (GameSongBuilder *builder in list) {
            NSLog(@"buildeder desc %@", [builder description]);
            XCTAssertNotNil(list);
        }
    }];
}

- (void)testPlaysong{
    GameSongDirector *director = [GameSongDirector new];
    [director gameMusicList:^(NSArray<id<AFSongProductDelegate>> *list) {
        GameSongProduct *product = list[0];
        [product playNextBeat];
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
