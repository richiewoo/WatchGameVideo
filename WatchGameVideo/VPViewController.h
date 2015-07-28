//
//  VPViewController.h
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface VPViewController : MPMoviePlayerViewController

@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *videoTitle;

@end
