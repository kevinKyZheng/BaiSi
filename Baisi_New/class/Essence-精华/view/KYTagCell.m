//
//  KYTagCell.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/11.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTagCell.h"
#import "KYTag.h"
@interface KYTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation KYTagCell

- (void)setTagModel:(KYTag *)tagModel{
    _tagModel = tagModel;
    //设置头像
    [self.imageListView setHead:tagModel.image_list];
    //主题
    self.themeLabel.text = tagModel.theme_name;

    //订阅数
    if (tagModel.sub_number>10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%0.1f万人订阅",tagModel.sub_number/10000.0];
    }else{
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number];
    }
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
