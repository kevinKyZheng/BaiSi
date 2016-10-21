//
//  KYSquareButton.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/18.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYSquareButton.h"
#import <UIButton+WebCache.h>
@implementation KYSquareButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:(UIControlStateNormal)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //imageView
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.height * 0.1;
    //titleLabel
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
- (void)setSquare:(KYSquare *)square{
    _square = square;
    [self setTitle:square.name forState:(UIControlStateNormal)];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:(UIControlStateNormal)];
}
@end
