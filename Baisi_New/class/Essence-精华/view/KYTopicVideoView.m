//
//  KYTopicVideoView.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopicVideoView.h"
#import <UIImageView+WebCache.h>
@interface KYTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation KYTopicVideoView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(KYTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放",topic.playcount];
    
}
@end
