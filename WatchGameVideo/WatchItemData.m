//
//  WatchItemData.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "WatchItemData.h"
#import "AFHTTPRequestOperationManager.h"

@implementation VideoItem


@end

#define KEY_REQUEST_STATUS              @"status"
#define KEY_REQUEST_STATUS_CODE         @"status_code"

#define KEY_REQUEST_RESPONSE            @"response"
#define KEY_RESPONSE_VIDEOLIST          @"video_list"

#define KEY_WATCH_ITEM_NEXTPAGE         @"next_page"
#define KEY_WATCH_ITEM_TITLE            @"title"
#define KEY_WATCH_THUMBNAILS            @"thumbnails"
#define KEY_WATCH_THUMBNAILS_REGULAR    @"regular"
#define KEY_WATCH_VIDEO_URL             @"video_url"

@interface WatchItemData ()

@property(nonatomic, strong) NSString *nextPage;
@property(nonatomic, strong) NSMutableArray* watchItems;

- (void)downloadWatchItemWithUrl: (NSString *)url;

@end

@implementation WatchItemData

- (NSArray *)getWatchListData{
    return self.watchItems;
}

- (void)downloadFirstPageWatchItem{
    [self downloadWatchItemWithUrl:@"https://app.kamcord.com/app/v3/feeds/featured_feed"];
}

- (void)downloadNextPageWatchItem{
    [self downloadWatchItemWithUrl:self.nextPage];
}

- (void)downloadWatchItemWithUrl: (NSString *)url{
    if (url != nil) {//Create HTTP request with URL
        NSURL *URL = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *res = responseObject[KEY_REQUEST_STATUS];
            if (res) {
                NSNumber *stCode = res[KEY_REQUEST_STATUS_CODE];
                if (stCode.intValue == 0) {
                    res = responseObject[KEY_REQUEST_RESPONSE];
                    NSDictionary *videoList = res[KEY_RESPONSE_VIDEOLIST];
                    self.nextPage = [NSString stringWithFormat:@"https://app.kamcord.com/app/v3/feeds/featured_feed?page=%@", videoList[KEY_WATCH_ITEM_NEXTPAGE]];
                    NSMutableArray* _d = [[NSMutableArray alloc] init];
                    [videoList[KEY_RESPONSE_VIDEOLIST] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                        VideoItem *item = [[VideoItem alloc]init];
                        item.title = obj[KEY_WATCH_ITEM_TITLE];
                        item.videoUrl = obj[KEY_WATCH_VIDEO_URL];
                        item.thumbnails = ((NSDictionary *)obj[KEY_WATCH_THUMBNAILS])[KEY_WATCH_THUMBNAILS_REGULAR];
                        [_d addObject:item];
                    }];
                    self.watchItems = [_d copy];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

@end
