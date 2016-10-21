//
//  NSDate+KYComparaion.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/15.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "NSDate+KYComparaion.h"

@implementation NSDate (KYComparaion)


- (NSDateComponents *)intervalToDate:(NSDate *)date
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | kCFCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents * componenets = [calendar components:unit fromDate:self toDate:date options:0];
    return componenets;
}

- (NSDateComponents *) intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}
/**
 *  判断是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *  nowDate= [calendar components:(NSCalendarUnitYear) fromDate:[NSDate date]];
    NSDateComponents *  selfDate= [calendar components:(NSCalendarUnitYear) fromDate:self];
    return nowDate.year == selfDate.year;
}
/**
 *  判断是否为今天 有两种实现方法:1.转成字符串 判断是否相等
 *  2.取出components 判断各个component是否相等
 */
//- (BOOL)isToday
//{
//    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//
//    NSString * selfStr = [fmt stringFromDate:self];
//    NSString * nowStr = [fmt stringFromDate:[NSDate date]];
//    return [selfStr isEqualToString:nowStr];
//}
- (BOOL)isToday
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * nowDate = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents * selfDate = [calendar components:unit fromDate:self];
    return nowDate.day == selfDate.day && nowDate.month == selfDate.month && nowDate.day == selfDate.day;
}
/**
 *  判断是否为昨天 把NsDate的格式换成只有年月日(中间要先转字符串再转回来),然后比较差得天数
 */
- (BOOL)isYesterday
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString * nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate * nowDate = [fmt dateFromString:nowStr];
    
    NSString * selfStr = [fmt stringFromDate:self];
    NSDate * selfDate = [fmt dateFromString:selfStr];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return comps.year == 0 && comps.month ==0 && comps.day == 1;
}
@end
