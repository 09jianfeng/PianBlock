//
//  GameSongDirector2TestCase.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameSongDirector2.h"
#import "Header.h"

@interface GameSongDirector2TestCase : XCTestCase

@end

@implementation GameSongDirector2TestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCSVParsing {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    GameSongDirector2 *gameSong = [GameSongDirector2 new];
    [gameSong gameMusicList:^(NSArray<id<AFSongProductDelegate>> *list) {
        
    }];
    
    WAIT
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
