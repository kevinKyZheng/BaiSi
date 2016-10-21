//
//  UITextField+KYPlaceHolderColor.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/15.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "UITextField+KYPlaceHolderColor.h"

static NSString * const KYPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (KYPlaceHolderColor)
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    BOOL change =NO;
    //保证有展位文字
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    //设置占位文字颜色
    [self setValue:placeHolderColor forKeyPath:KYPlaceholderColorKey];
    //恢复原状
    if (change == YES) {
        self.placeholder = nil;
    }
}
- (UIColor *)placeHolderColor
{
    return [self valueForKey:KYPlaceholderColorKey];
}
@end
