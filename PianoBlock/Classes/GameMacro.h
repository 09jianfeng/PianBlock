//
//  GameMacro.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#ifndef GameMacro_h
#define GameMacro_h

#define WeakSelf __weak typeof(self) weakSelf = self

#ifdef DEBUG
#define GAMELOG(xx, ...) NSLog(@"<Info>" xx,##__VA_ARGS__)
#else
#define GAMELOG(xx,...) ((void)0);
#endif

#endif /* GameMacro_h */
