//
//  ViewController.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "MainViewController.h"
#import "WatchItemData.h"
#import "WatchCellTableViewCell.h"
#import "WatchVideoListDataSource.h"
#import "VPViewController.h"
#import "MJRefresh.h"

@interface MainViewController ()

@property(nonatomic, strong) WatchItemData *watchItems;
@property(nonatomic, strong) WatchVideoListDataSource *watchListDataSource;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationItem setTitle:@"Watch View"];
    _watchItems = [[WatchItemData alloc] init];
    [self.watchItems downloadFirstPageWatchItem];
    //KVO programming
    [self.watchItems addObserver:self forKeyPath:VIDEO_DATA_OBSERVER_KEY options:NSKeyValueObservingOptionOld context:nil];
}

- (void)setupTableView{
    TableViewCellConfigureBlock configureCell = ^(WatchCellTableViewCell *cell, VideoItem *videoInfo) {
        [cell setVideoInfo:videoInfo.title thumbnail:videoInfo.thumbnails];
    };
    _watchListDataSource = [[WatchVideoListDataSource alloc] initWithItems:[self.watchItems getWatchListData] configureCellBlock:configureCell];
    self.tableView.dataSource = self.watchListDataSource;
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.tableView reloadData];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.watchItems downloadNextPageWatchItem];
        // End Refreshing
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:VIDEO_DATA_OBSERVER_KEY]){
        [self setupTableView];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT_FOR_ROW;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoItem *item = [self.watchItems getWatchListData][indexPath.row];
    VPViewController *vc = [[VPViewController alloc] initWithContentURL:[NSURL URLWithString:item.videoUrl]];
    vc.videoUrl = item.videoUrl;
    vc.videoTitle = item.title;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
