//
//  UILabel+EasyExtend.m
//  leway
//
//  Created by 朱潮 on 14-6-6.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "UILabel+EasyExtend.h"

@implementation UILabel (EasyExtend)

//ios6 later
-(CGSize)autoSize{
    return [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.preferredMaxLayoutWidth = 300;
    }
    return self;
}

/**
 *  fixes issues with embedding a `UILabel` in a `UIScrollScrollView`.
 *  @see http://www.raywenderlich.com/73602/dynamic-table-view-cell-height-auto-layout for examples and in-depth discussion on why this is needed.
 *
 *  @discussion Setting the label's `bounds` will update the `preferredMaxLayoutWidth`.
 */
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    if (bounds.size.width != self.preferredMaxLayoutWidth) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}
@end
