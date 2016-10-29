//
//  Header.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/10/28.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define WAIT                                                                \
do {                                                                        \
[self expectationForNotification:@"YMDUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil];                   \
} while(0);

#define NOTIFY                                                                            \
do {                                                                                      \
[[NSNotificationCenter defaultCenter] postNotificationName:@"YMDUnitTest" object:nil]; \
} while(0);

#endif /* Header_h */
