//
//  KYPlaceHolderTextView.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/21.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYPlaceHolderTextView.h"

@implementation KYPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //默认颜色,默认文字
        self.placeholderColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:15];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:(UITextViewTextDidChangeNotification) object:nil];
    }
    return self;
}
- (void)textDidChange{
    [self setNeedsDisplay];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)drawRect:(CGRect)rect{
    if (self.hasText) return;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = self.font;
    dic[NSForegroundColorAttributeName] = self.placeholderColor;
    
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:dic];
}
@end
