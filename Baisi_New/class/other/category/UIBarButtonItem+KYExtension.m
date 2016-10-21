//
//  UIBarButtonItem+KYExtension.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "UIBarButtonItem+KYExtension.h"

@implementation UIBarButtonItem (KYExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    //
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc]initWithCustomView:button];
}
@end
