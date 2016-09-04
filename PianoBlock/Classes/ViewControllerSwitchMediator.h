//
//  ViewControllerSwitchMediator.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewControllerVM.h"

@interface ViewControllerSwitchMediator : NSObject

+ (instancetype)shareInstance;

- (void)showGameViewController:(UIViewController *)currentController viewControllerVM:(ViewControllerVM *)viewModel;

@end
