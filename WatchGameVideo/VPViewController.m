//
//  VPViewController.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "VPViewController.h"
#import <MediaPlayer/MPMoviePlayerController.h>

@implementation VPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.videoTitle;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(playbackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

- (void)playbackDidFinish:(NSNotification*)aNotifacaiotn{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
