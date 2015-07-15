//
//  WatchVideoListDataSource.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "WatchVideoListDataSource.h"
#import "WatchItemData.h"
#import "WatchCellTableViewCell.h"

@interface WatchVideoListDataSource ()

@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, copy)     TableViewCellConfigureBlock configureCellBlock;

@end

@implementation WatchVideoListDataSource

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoItem* item = [self itemAtIndexPath:indexPath];
    WatchCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([item class])];
    if (cell == nil) {
        cell  = [[WatchCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([item class])];
    }
    
    self.configureCellBlock(cell, item);
    return cell;
}

@end
