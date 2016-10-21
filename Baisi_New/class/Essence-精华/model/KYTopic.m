//
//  KYTopic.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/8.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopic.h"

@implementation KYTopic
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = KYTopicTextY;
        
        //文字的高度
        CGFloat textW = KYScreenW - 2 * KYCommonMargin;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight += textH + KYCommonMargin;
        //中间内容的高度
        if (self.type != KYTopicTypeWord) {
            CGFloat contentW = textW;
            CGFloat contentH = self.height * contentW /self.width;
            if (contentH > KYScreenH) {
                contentH = 300;
                self.isBigPicture = YES;
            }
            CGFloat contentX = KYCommonMargin;
            CGFloat contentY = _cellHeight;
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            _cellHeight += KYCommonMargin + contentH;
        }
        
        //工具栏
        _cellHeight += KYTopicToolBarH + KYCommonMargin;
    }
    return _cellHeight;
}
- (NSString *)created_at{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate * createdAtDate = [fmt dateFromString:_created_at];
    NSDateComponents * cmps = [createdAtDate intervalToNow];
    if (createdAtDate.isThisYear) {
        if (createdAtDate.isToday) { // 今天
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1分钟 =< 时间差距 <= 59分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 今年的其他时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _created_at;
    }
}

@end
