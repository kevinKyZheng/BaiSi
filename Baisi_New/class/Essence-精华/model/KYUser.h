//
//  KYUser.h
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/18.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
