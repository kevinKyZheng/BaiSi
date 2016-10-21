//
//  NSDictionary+KYDescription.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/20.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "NSDictionary+KYDescription.h"

@implementation NSDictionary (KYDescription)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}
@end
