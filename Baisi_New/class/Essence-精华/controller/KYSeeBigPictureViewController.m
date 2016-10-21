//
//  KYSeeBigPictureViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/13.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface KYSeeBigPictureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIImageView * imageView;
//@property(nonatomic,strong)ALAssetsLibrary * library;
@property(nonatomic,strong)PHPhotoLibrary * library;

@end

@implementation KYSeeBigPictureViewController
- (PHPhotoLibrary *)library{
    if (!_library) {
        _library = [[PHPhotoLibrary alloc]init];
    }
    return _library;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //scrollView
    UIScrollView * scrollView= [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    [scrollView addGestureRecognizer:([[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)])];
    //imageView
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    //image的尺寸
    imageView.x = 0 ;
    imageView.width = KYScreenW;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    if (imageView.height > KYScreenH) {
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0,imageView.height);
    }else{
        imageView.centerY = KYScreenH * 0.5;
    }
    // 伸缩
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
}
#pragma mark scrollView Zoom
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
@end
