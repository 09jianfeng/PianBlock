//
//  AudioBeatsCacheTest.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/11/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AudioBeatsCache.h"
#import "Header.h"

@interface AudioBeatsCacheTest : XCTestCase

@end

@implementation AudioBeatsCacheTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAudioBeatsCache {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    AudioBeatsCache *beatsCache = [AudioBeatsCache shareInstance];
    
    NSData *beatData = [beatsCache beatDataByName:@"#A-1.mp3"];
    XCTAssertNotNil(beatData,@"beatData not nil");
    
    NOTIFYINIT;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NOTIFY;
    });
    WAITWITHTIME(10);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
