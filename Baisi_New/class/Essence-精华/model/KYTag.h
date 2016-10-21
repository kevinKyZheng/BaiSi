//
//  KYTag.h
//  Baisi_New
//
//  Created by 郑开元 on 16/9/11.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
@end
