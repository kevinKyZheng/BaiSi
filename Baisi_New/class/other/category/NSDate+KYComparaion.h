//
//  NSDate+KYComparaion.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/15.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KYComparaion)
- (NSDateComponents *) intervalToNow;
- (NSDateComponents *)intervalToDate:(NSDate *)date;
/**
 *  判断是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断是否为今天
 */
- (BOOL)isToday;
/**
 *  判断是否为昨天
 */
- (BOOL)isYesterday;
@end
