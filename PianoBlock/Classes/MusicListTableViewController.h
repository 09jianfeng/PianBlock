//
//  MusicListTableViewController.h
//  PianoBlock
//
//  Created by JFChen on 16/10/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicListViewModel;
@interface MusicListTableViewController : UITableViewController

@property(nonatomic, strong) MusicListViewModel *mlViewModel;

@end
