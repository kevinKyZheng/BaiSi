//
//  KYNavigationController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYNavigationController.h"

@interface KYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KYNavigationController

+(void)initialize{
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:(UIBarMetricsDefault)];
    self.interactivePopGestureRecognizer.delegate =self;
}
/**
 *  拦截所有push进来的控制器
 *
 *  @param viewController push进的控制器
 *  @param animated       animated description
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >=1) {
        UIButton * backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:(UIControlStateNormal)];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [backBtn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        [backBtn sizeToFit];
        //
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];;
        viewController.hidesBottomBarWhenPushed = YES;
  
    }
//    放在后面的目的:
//      一旦调用super 就会调用viewdidload方法,无法在viewdidiload中个性化的设置.
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}
#pragma mark UIGestureRecognizerDelegate
/**
 *  每次调用返回手势的时候触发
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1 )return NO;
    return YES;
}
@end
