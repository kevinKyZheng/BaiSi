//
//  KYPulishButton.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/20.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYPulishButton.h"

@implementation KYPulishButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //imageView
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    
    //title
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.x = 0;
    
}
@end
