//
//  KYTopic.h
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/8.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    KYTopicTypeAll = 1,
    KYTopicTypePicture = 10,
    KYTopicTypeVideo = 41,
    KYTopicTypeWord = 29,
    KYTopicTypeVoice = 31
}KYTopicType;

@interface KYTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID; // id
// 用户 -- 发帖者
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 类型 */
@property (nonatomic, assign) KYTopicType type;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image; // image0
/** 大图 */
@property (nonatomic, copy) NSString *large_image; // image1
/** 中图 */
@property (nonatomic, copy) NSString *middle_image; // image2

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;

/** 最热评论 */
//@property (nonatomic, strong) XMGComment *topComment;
/******额外增加的属性************/
//cell的高度
@property(nonatomic,assign)CGFloat cellHeight;
//cell中间内容的高度
@property(nonatomic,assign)CGRect contentFrame;
//是否是大图
@property (nonatomic,assign,getter=isBigPicture) BOOL isBigPicture;

@end
