//
//  KYTopicPictureView.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/10.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "KYSeeBigPictureViewController.h"
@interface KYTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end

@implementation KYTopicPictureView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners =5;
    self.progressView.progressLabel.textColor = [UIColor grayColor];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:(    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)])];
}
- (void)imageClick{
    if (self.imageView.image == nil) return;
    KYSeeBigPictureViewController * seebigPictureVC = [[KYSeeBigPictureViewController alloc]init];
    seebigPictureVC.topic = self.topic;
    [self.window.rootViewController presentViewController:seebigPictureVC animated:YES completion:nil];
}
- (void)setTopic:(KYTopic *)topic{
    _topic = topic;
    KYWeakSelf
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:(0) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",100 * weakSelf.progressView.progress];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    //是gif
    self.gif.hidden = !topic.is_gif;
    //隐藏大图
    self.seeBigPicture.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        _imageView.contentMode = UIViewContentModeTop
        ;
        _imageView.clipsToBounds = YES;
    }else{
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.contentMode = NO;
    }
}

@end
