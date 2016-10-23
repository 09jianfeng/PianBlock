//
//  MusicListTableViewController.m
//  PianoBlock
//
//  Created by JFChen on 16/10/22.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "ViewControllerSwitchMediator.h"
#import "MusicListViewModel.h"
#import "GameBeatSongBuilder.h"

@interface MusicListTableViewController ()

@end

@implementation MusicListTableViewController{
    NSArray<GameBeatSongBuilder *> *tableViewDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"musicListCellIdentifier"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    headerView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMlViewModel:(MusicListViewModel *)mlViewModel{
    _mlViewModel = mlViewModel;
    tableViewDataSource = [_mlViewModel mListTableVCDataSource];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicListCellIdentifier" forIndexPath:indexPath];
    GameBeatSongBuilder *songBuilder = tableViewDataSource[indexPath.row];
    
    cell.textLabel.text = songBuilder.music;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"tid:%@ music:%@ price:%@",songBuilder.tid,songBuilder.music,songBuilder.price];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
    headerView.backgroundColor = [UIColor purpleColor];
    
    return headerView;
}

@end
