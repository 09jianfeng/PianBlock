//
//  Header.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define WAITINIT(x) XCTestExpectation *wait = [self expectationWithDescription:x];
#define WAITWITHTIME(x) [self waitForExpectationsWithTimeout:x handler:^(NSError * _Nullable error) {NSLog(@"%s end",__FUNCTION__);}];
#define NOTIFY [wait fulfill];
#endif /* Header_h */
