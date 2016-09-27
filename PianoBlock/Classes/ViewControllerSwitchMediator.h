//
//  ViewControllerSwitchMediator.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RVCViewModel.h"

@class RootViewController;

@interface ViewControllerSwitchMediator : NSObject

+ (instancetype)shareInstance;

- (void)showGameViewController:(RootViewController *)currentController RVCViewModel:(RVCViewModel *)viewModel;

- (void)dismissCurrentController;

@end
