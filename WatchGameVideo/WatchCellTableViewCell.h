//
//  WatchCellTableViewCell.h
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_HEIGHT_FOR_ROW 110

@interface WatchCellTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel* title;
@property(nonatomic, strong) UIImageView* thumbnail;

- (void)UIInit;
- (void) setVideoInfo:(NSString *) titleName thumbnail:(NSString *)imgUrl;

@end
