//
//  KYTitleButton.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/9/26.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTitleButton.h"

@implementation KYTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [self setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        
    }
    return self;
}
@end
