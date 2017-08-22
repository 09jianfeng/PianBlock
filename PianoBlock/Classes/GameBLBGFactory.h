//
//  GameBLBGFactory.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/5.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BLBackgroundType){
    BLBackgroundTypeWhite,
    BLBackgroundTypeBlack
};

@interface GameBLBGFactory : NSObject

- (UIImage *)blockBackgroundWithType:(BLBackgroundType)type;

@end
