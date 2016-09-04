//
//  ViewControllerSwitchMediator.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerSwitchMediator : NSObject

+ (instancetype)shareInstance;

- (void)showGameViewController:(UIViewController *)currentController;

@end
