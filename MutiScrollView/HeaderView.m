//
//  HeaderView.m
//  MutiScrollView
//
//  Created by zhuchao on 15/3/5.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()
@property(nonatomic,retain)UIImageView *imageView;
@end
@implementation HeaderView

-(instancetype)init{
    self = [super init];
    if(self){
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/e7cd7b899e510fb32396f5f0da33c895d0430ccd.jpg"]];
        [_imageView alignToView:self];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
        [_imageView addGestureRecognizer:gesture];
    }
    return self;
}

-(void)touch{
    NSLog(@"touched");
}

@end
