//
//  KYTabBar.m
//  Baisi_New
//
//  Created by 郑开元 on 16/5/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTabBar.h"
#import "KYPulishViewController.h"
#import "KYNavigationController.h"

@interface KYTabBar()
@property(nonatomic,weak)UIButton * plusBtn;
@end

@implementation KYTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
//        添加按钮
        UIButton * plusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [plusBtn sizeToFit];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  点击添加按钮
 */
- (void)plusBtnClick{
    KYPulishViewController * pulishVc = [[KYPulishViewController alloc]init];
    KYNavigationController * nav = [[KYNavigationController alloc]initWithRootViewController:pulishVc];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

//布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
//    tabbar各个按钮的尺寸
    CGFloat tabbarW = self.frame.size.width;
    CGFloat tabbarH = self.frame.size.height;
    CGFloat tabbarItemY = 0;
    CGFloat tabbarItemW = tabbarW * 0.2;
    CGFloat tabbarItemH = tabbarH;
//    加号按钮尺寸
    self.plusBtn.center = CGPointMake(tabbarW * 0.5, tabbarH * 0.5);
    int index = 0;
//    重新排列各个按钮位置
    for (UIView * tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        CGFloat tabbarItemX = index * tabbarItemW;
        if (index >= 2) {
            tabbarItemX += tabbarItemW;
        }
        tabBarButton.frame = CGRectMake(tabbarItemX, tabbarItemY, tabbarItemW, tabbarItemH);
        index++;
    }
}
@end
