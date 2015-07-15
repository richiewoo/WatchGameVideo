//
//  WatchItemData.h
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoItem : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *thumbnails;
@property(nonatomic, strong) NSString *videoUrl;

@end

#define VIDEO_DATA_OBSERVER_KEY @"watchItems"
@interface WatchItemData : NSObject

- (NSArray *)getWatchListData;
- (void)downloadFirstPageWatchItem;
- (void)downloadNextPageWatchItem;

@end
