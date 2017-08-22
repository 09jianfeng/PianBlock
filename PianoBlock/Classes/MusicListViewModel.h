//
//  MusicListViewModel.h
//  PianoBlock
//
//  Created by JFChen on 16/10/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongAbstractFactory.h"

@interface MusicListViewModel : NSObject

- (void)mListTableVCDataSource:(void (^)(NSArray<id<AFSongProductDelegate>> *list))completeBlock;

@end
