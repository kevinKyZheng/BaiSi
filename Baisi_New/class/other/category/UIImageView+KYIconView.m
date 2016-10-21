//
//  UIImageView+KYIconView.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/14.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "UIImageView+KYIconView.h"
//#import <UIImageView+WebCache.h>

@implementation UIImageView (KYIconView)
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}
- (void)setRectHeader:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
- (void)setCircleHeader:(NSString *)url
{
    KYWeakSelf;
    UIImage * placeHolderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        weakSelf.image = [image circleImage];
    }];
    
    
}
@end
