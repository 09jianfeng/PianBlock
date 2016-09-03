//
//  GameCountdownWindow.h
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/2.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)();

@interface GameCountdownWindow : UIView

+ (instancetype)shareInstance;

- (void)showWithAnimNum:(NSInteger)anim CompleteBlock:(CompleteBlock)completeBlock;

@end
