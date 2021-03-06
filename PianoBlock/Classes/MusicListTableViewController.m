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
#import "GameSongProduct2.h"
#import "GameMacro.h"

@interface MusicListTableViewController ()
@property (nonatomic ,strong) NSArray<GameSongProduct2 *> *tableViewDataSource;
@end

@implementation MusicListTableViewController{
    
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
    
    WeakSelf
    [self.mlViewModel mListTableVCDataSource:^(NSArray<id<AFSongProductDelegate>> *list) {
        weakSelf.tableViewDataSource = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMlViewModel:(MusicListViewModel *)mlViewModel{
    _mlViewModel = mlViewModel;
    [_mlViewModel mListTableVCDataSource:^(NSArray<id<AFSongProductDelegate>> *list) {
        _tableViewDataSource = list;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicListCellIdentifier" forIndexPath:indexPath];
    GameSongProduct2 *songProduct = _tableViewDataSource[indexPath.row];
    cell.textLabel.text = songProduct.file;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
    headerView.backgroundColor = [UIColor purpleColor];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
