//
//  KYComment.h
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/18.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KYUser;

@interface KYComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) KYUser *user;

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 语音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
@end
