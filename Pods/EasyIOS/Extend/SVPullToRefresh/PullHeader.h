//
//  PullHeader.h
//  mcapp
//
//  Created by zhuchao on 14/11/21.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "Header.h"

@interface PullHeader : Header
@property(nonatomic,retain)UILabel *statusLabel;
@property(nonatomic,retain)UILabel *lastUpdateTimeLabel;
@property(nonatomic,retain)UIImageView *arrowImage;
@property(nonatomic,retain)UIActivityIndicatorView *activityView;

@end
