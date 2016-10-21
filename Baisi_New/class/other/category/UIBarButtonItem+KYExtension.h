//
//  UIBarButtonItem+KYExtension.h
//  Baisi_New
//
//  Created by 郑开元 on 16/9/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KYExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
