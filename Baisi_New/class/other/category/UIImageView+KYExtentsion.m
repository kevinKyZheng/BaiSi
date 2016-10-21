//
//  UIImageView+KYExtentsion.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/11.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "UIImageView+KYExtentsion.h"
#import "UIImage+KYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (KYExtentsion)
- (void)setHead:(NSString *)url{
    UIImage * image = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    KYWeakSelf;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        weakSelf.image = [image circleImage];
    }];
}
@end
