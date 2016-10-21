//
//  NSString+KYFileCache.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "NSString+KYFileCache.h"

@implementation NSString (KYFileCache)

- (NSInteger)fileCache{
    NSFileManager * mng = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExist = [mng fileExistsAtPath:self isDirectory:&isDirectory];
    if (isExist == NO) return 0;
    if (isDirectory == YES) {//判断是不是文件夹
        NSInteger size = 0;
        NSDirectoryEnumerator * enumerator = [mng enumeratorAtPath:self];
        for (NSString * subPath in enumerator) {
            NSString * filePath = [self stringByAppendingPathComponent:subPath];
            size += [mng attributesOfItemAtPath:filePath error:nil].fileSize;
        }
        return size;
    }else{
        return [mng attributesOfItemAtPath:self error:nil].fileSize;
    }
}
@end
