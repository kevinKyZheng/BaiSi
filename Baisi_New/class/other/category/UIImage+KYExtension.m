//
//  UIImage+KYExtension.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/11.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "UIImage+KYExtension.h"

@implementation UIImage (KYExtension)
-(instancetype)circleImage{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(instancetype)circleImageNamed:(NSString *)name{
    return [[self imageNamed:name] circleImage];
}
@end
