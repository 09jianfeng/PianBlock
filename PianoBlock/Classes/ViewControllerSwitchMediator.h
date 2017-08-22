//
//  ViewControllerSwitchMediator.h
//  PianoBlock
//
//  Created by JFChen on 16/9/4.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RootViewController;
@class RVCViewModel;
@class MusicListViewModel;

@interface ViewControllerSwitchMediator : NSObject

+ (instancetype)shareInstance;

// show game playing scene
- (void)showGameViewController:(RootViewController *)currentController RVCViewModel:(RVCViewModel *)viewModel;

// music list controller
- (void)showMusciListVC:(RootViewController *)currentController RVCViewModel:(RVCViewModel *)viewModel;

- (void)dismissCurrentController;

@end
