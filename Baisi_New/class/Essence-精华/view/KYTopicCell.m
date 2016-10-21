//
//  KYTopicCell.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/8.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopicCell.h"
#import "KYTopicVideoView.h"
#import "KYTopicVoiceView.h"
#import "KYTopicPictureView.h"
#import "KYCommentViewController.h"

@interface KYTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatAtLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property(nonatomic,weak)KYTopicVideoView * videoView;
@property(nonatomic,weak)KYTopicPictureView * pictureView;
@property(nonatomic,weak)KYTopicVoiceView * voiceView;
@end

@implementation KYTopicCell
//懒加载
- (KYTopicVideoView *)videoView{
    if (!_videoView) {
        KYTopicVideoView * videoView = [KYTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (KYTopicVoiceView *)voiceView{
    if (!_voiceView) {
        KYTopicVoiceView * voiceView = [KYTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
-(KYTopicPictureView *)pictureView{
    if (!_pictureView) {
        KYTopicPictureView * pictureView = [KYTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
//设置中间内容
- (void)setTopic:(KYTopic *)topic{
    _topic = topic;
    //设置基本内容
    [self.profileImageView setHead:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.creatAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    //设置底部按钮数字
    [self setupButton:self.dingBtn number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiBtn number:topic.cai placeholder:@"踩"];
    [self setupButton:self.commentBtn number:topic.comment placeholder:@"评论"];
    [self setupButton:self.shareBtn number:topic.repost placeholder:@"分享"];
    //根据类型选择中间内容的view
    if (topic.type == KYTopicTypeVoice) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.contentFrame;
    }else if (topic.type == KYTopicTypeVideo){
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.contentFrame;
    }else if (topic.type == KYTopicTypePicture){
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.contentFrame;
    }else if (topic.type == KYTopicTypeWord){
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    /*if (topic.type == KYTopicTypePicture){
        self.pictureView.frame = topic.contentFrame;
    }*/
}
- (void)setFrame:(CGRect)frame{
    frame.origin.y += KYCommonMargin;
    frame.size.height -= KYCommonMargin;
    [super setFrame:frame];
}
- (IBAction)moreBtnClick:(id)sender {
   // UIAlertController * alertVc = []
}
/**
 *设置底部按钮文字
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%0.1f万",(number / 10000.0)] forState:(UIControlStateNormal)];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:(UIControlStateNormal)];
    }else{
        [button setTitle:placeholder forState:(UIControlStateNormal)];
    }
}
- (IBAction)commentBtnClick:(id)sender {
//    NSLog(@"1111%@",self.window.rootViewController);
//    UIViewController * vc = [sender parentViewController];
//    NSLog(@"2222%@",vc);
//    KYCommentViewController * commentVc = [[KYCommentViewController alloc]init];
//    commentVc.topic = self.topic;
//    [self.window.rootViewController.navigationController pushViewController:commentVc animated:YES];
}
@end
