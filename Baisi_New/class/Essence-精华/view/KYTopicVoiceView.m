//
//  KYTopicVoiceView.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopicVoiceView.h"
#import <UIImageView+WebCache.h>

@interface KYTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@end

@implementation KYTopicVoiceView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(KYTopic *)topic{
    _topic = topic;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    // %02zd ：显示这个数字需要占据2位空间，不足的空间用0替补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end
