//
//  WatchCellTableViewCell.m
//  WatchGameVideo
//
//  Created by Xinbo Wu on 7/13/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "WatchCellTableViewCell.h"
#import "SDWebImageDownloader.h"
#import "UIImage+ProportionalFill.h"


#define CELL_SIZE_HEIGTH   100

#define THUMBNAIL_SIZE_WIDTH    160
#define THUMBNAIL_SIZE_HEIGTH   100
#define TITLE_SIZE_HEIGTH  35
#define CONTROL_PADDING  5


#pragma mark - cell

@interface WatchCellTableViewCell ()
@property(nonatomic, strong) UIView *backGroundView;
@end

@implementation WatchCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self UIInit];
    }
    
    return self;
}

//init the subview
- (void)UIInit
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.contentView.frame.size.width, CELL_SIZE_HEIGTH);
    self.backgroundColor = [UIColor grayColor];
    
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(CONTROL_PADDING, CONTROL_PADDING, self.bounds.size.width-2*CONTROL_PADDING, CELL_SIZE_HEIGTH)];
    self.backGroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backGroundView.backgroundColor = [UIColor lightGrayColor];
    self.backGroundView.layer.cornerRadius = 4;
    [self addSubview:self.backGroundView];
    
    CGRect _frame = CGRectMake(0, 0, THUMBNAIL_SIZE_WIDTH, CELL_SIZE_HEIGTH);
    self.thumbnail = [[UIImageView alloc] initWithFrame:_frame];
    [self.backGroundView addSubview:self.thumbnail];
    
    _frame = CGRectMake(_frame.origin.x + _frame.size.width+CONTROL_PADDING, (self.frame.size.height-TITLE_SIZE_HEIGTH)/2, self.contentView.frame.size.width - _frame.size.width, TITLE_SIZE_HEIGTH);
    self.title = [[UILabel alloc] initWithFrame:_frame];
    [self.backGroundView addSubview:self.title];
}


- (void) setVideoInfo:(NSString *) titleName thumbnail:(NSString *)imgUrl
{
    self.title.text = titleName;
    
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:imgUrl]
                                                        options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         if (image && finished)
         {  // do something with image
             self.thumbnail.image = [image imageCroppedToFitSize:self.thumbnail.frame.size];
         }
     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
