
//
//  UIImage+KYCircleImage.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/14.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "UIImage+KYCircleImage.h"

@implementation UIImage (KYCircleImage)
- (UIImage *)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end
