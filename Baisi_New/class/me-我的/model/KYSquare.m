//
//  KYSquare.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYSquare.h"

@implementation KYSquare
- (NSString *)description{
    NSString * string = [NSString stringWithFormat:@"%@-----%@-----%@",self.name,self.icon,self.url];
    return string;
}
@end
