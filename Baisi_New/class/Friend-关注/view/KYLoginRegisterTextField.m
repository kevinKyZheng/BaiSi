//
//  KYLoginRegisterTextField.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/10.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYLoginRegisterTextField.h"
#define KYPlaceholderDefaultColore [UIColor grayColor]
#define KYPlaceholderFocusColore  [UIColor whiteColor]
@implementation KYLoginRegisterTextField
-(void)awakeFromNib{
    self.textColor = KYPlaceholderFocusColore;
    self.tintColor = KYPlaceholderFocusColore;
    self.placeHolderColor = KYPlaceholderDefaultColore;
}
/**
 *  文本框聚焦时文本框的颜色
 */
-(BOOL)becomeFirstResponder{
    self.placeHolderColor= KYPlaceholderFocusColore;
    return [super becomeFirstResponder];
}
/**
 *  文本框失焦时文本框的颜色
 */
-(BOOL)resignFirstResponder{
    self.placeHolderColor = KYPlaceholderDefaultColore;
    return [super resignFirstResponder];
}
@end
