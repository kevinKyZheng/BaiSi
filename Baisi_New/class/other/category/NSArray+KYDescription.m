//
//  NSArray+KYDescription.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/20.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "NSArray+KYDescription.h"

@implementation NSArray (KYDescription)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end
