
//
//  KYMeCell.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/12.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYMeCell.h"

@implementation KYMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor grayColor];
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.y = KYCommonMargin * 0.5;
    self.imageView.height = self.contentView.height - KYCommonMargin;
    self.imageView.width = self.imageView.height;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + KYCommonMargin;
}
@end
