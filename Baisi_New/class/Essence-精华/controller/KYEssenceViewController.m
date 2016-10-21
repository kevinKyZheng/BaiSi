//
//  KYEssenceViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/5/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYEssenceViewController.h"
#import "KYTagViewController.h"
#import "KYTopicViewController.h"
#import "KYAllViewController.h"
#import "KYPictureViewController.h"
#import "KYWordViewController.h"
#import "KYVideoViewController.h"
#import "KYVoiceViewController.h"
#import "KYTitleButton.h"

@interface KYEssenceViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView * titleView;
@property(nonatomic,weak)UIView * bottomView;
@property(nonatomic,weak)KYTitleButton * selectedButton;
@property(nonatomic,weak)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * buttons;

@end

@implementation KYEssenceViewController
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupChildVcs];
    [self setupScrollView];
    [self setupTitleView];
}
#pragma mark 初始化函数
- (void)setupNav{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}
- (void)setupChildVcs{
    KYAllViewController * allVc = [[KYAllViewController alloc]init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    KYPictureViewController * pictureVc = [[KYPictureViewController alloc]init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    KYWordViewController * wordVc = [[KYWordViewController alloc]init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
    KYVideoViewController * videoVc = [[KYVideoViewController alloc]init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    KYVoiceViewController * voiceVc = [[KYVoiceViewController alloc]init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
}
- (void)setupTitleView{
    UIView * titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titleView.frame = CGRectMake(0,KYNavBarMaxY,KYScreenW,KYTitleViewH);
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    //buttons
    NSUInteger count = self.childViewControllers.count;
    CGFloat buttonW = KYScreenW / count;
    CGFloat buttonH = KYTitleViewH;
    for (int i = 0 ; i < count; i++) {
        //button
        KYTitleButton * btn = [KYTitleButton buttonWithType:(UIButtonTypeCustom)];
        [btn addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.buttons addObject:btn];
        [self.titleView addSubview:btn];
        //文字
        NSString * text = self.childViewControllers[i].title ;
        [btn setTitle:text forState:(UIControlStateNormal)];
        //frame
        btn.x = i * buttonW;
        btn.y = 0;
        btn.width = buttonW;
        btn.height = buttonH;
    }
    //底部view
    UIView * bottemView = [[UIView alloc]init];
    bottemView.backgroundColor = [UIColor redColor];
    bottemView.height = 2;
    bottemView.y = self.titleView.height - bottemView.height;
    [self.titleView addSubview:bottemView];
    self.bottomView = bottemView;
    //默认
    KYTitleButton * firstBtn = [self.buttons firstObject];
    self.bottomView.centerX = firstBtn.centerX;
    self.bottomView.width = firstBtn.width;
    [self titleViewBtnClick:firstBtn];
}
- (void)setupScrollView{
#warning 为什么要设置这个
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.pagingEnabled = YES;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = KYBgColor;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * KYScreenW, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //默认显示第一个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
#pragma mark 按键响应函数
- (void)titleViewBtnClick:(KYTitleButton *)button{
    //改变按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    //titleView底部线移动
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.width = button.width;
        self.bottomView.centerX = button.centerX;
    }];
    //改变scrollView中的view移动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.buttons indexOfObject:button];
    [self.scrollView setContentOffset:offset animated:YES];
}
- (void)tagClick{
    KYTagViewController * tagVc = [[KYTagViewController alloc]init];
    [self.navigationController pushViewController:tagVc animated:YES];
}
#pragma mark ScrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //取出即将要显示的VC
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController * willShowVc = self.childViewControllers[index];
    //如果view加载过 就返回
    if (willShowVc.isViewLoaded) return;
    //
    willShowVc.view.frame = scrollView.bounds;
    [self.scrollView addSubview:willShowVc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleViewBtnClick:self.buttons[index]];
}
/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    CGFloat titleBtnW = self.titleView.width / 5;
    //int index= (scrollView.contentOffset.x \ scrollView.width);
    self.bottomView.x += scrollView.contentOffset.x / scrollView.width;
}*/
@end
