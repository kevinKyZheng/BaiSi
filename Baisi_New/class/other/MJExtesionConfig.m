
//
//  MJExtesionConfig.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/10.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "MJExtesionConfig.h"
#import <MJExtension.h>
#import "KYTopic.h"
#import "KYComment.h"

@implementation MJExtesionConfig
+ (void)load{
    [KYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 @"topComment" : @"top_cmt[0]"
                 };
    }];
    
    [KYComment mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}
@end
