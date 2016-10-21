//
//  GameStopView.h
//  PianoBlock
//
//  Created by JFChen on 16/10/15.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface GameStopView : UIView
@property (nonatomic, strong) RACSignal *backBtnSignal;
@property (nonatomic, strong) RACSignal *replayBtnSignal;


- (void)subViewSetup;

@end
