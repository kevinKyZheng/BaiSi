//
//  KYCommentCell.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/18.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYCommentCell.h"
#import "KYUser.h"
@interface KYCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;

@end

@implementation KYCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setComment:(KYComment *)comment{
    _comment = comment;
    
    [self.profileImageView setHead:comment.user.profile_image];
    self.nameLabel.text = comment.user.username;
    self.contentTextLabel.text = comment.content;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    if ([comment.user.sex isEqualToString:KYUserSaxMale]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womenIcon"];
    }
}

@end
