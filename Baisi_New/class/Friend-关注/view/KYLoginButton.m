//
//  KYLoginButton.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/10.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYLoginButton.h"

@implementation KYLoginButton
- (void)awakeFromNib{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    //
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}
@end
