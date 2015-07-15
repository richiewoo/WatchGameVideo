//
//  VPViewController.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "VPViewController.h"
#import <WebKit/WebKit.h>

@interface VPViewController ()

@property (nonatomic, strong) UIProgressView* progressView;
@property (nonatomic, strong) WKWebView* webView;

@end

@implementation VPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.videoTitle;
    
    CGRect _frame = self.view.frame;
    _webView = [[WKWebView alloc] initWithFrame:_frame];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_webView];
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    _frame.origin.y = self.navigationController.navigationBar.frame.size.height+statusBarHeight;
    _frame.size.height = statusBarHeight;
    _progressView = [[UIProgressView alloc] initWithFrame:_frame];
    [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.progressTintColor = [UIColor grayColor];
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
    [self.view addSubview:_progressView];
    
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view setAutoresizesSubviews:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:self.videoUrl]];
            [self.webView loadRequest:urlReq];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:NULL];
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setProgress:self.webView.estimatedProgress];
        if (self.webView.estimatedProgress >= 1) {
            self.progressView.progress = 0;
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
