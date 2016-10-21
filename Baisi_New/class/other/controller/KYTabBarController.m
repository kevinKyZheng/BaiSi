//
//  KYTabBarController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/5/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTabBarController.h"
#import "KYEssenceViewController.h"
#import "KYFriendViewController.h"
#import "KYMeViewController.h"
#import "KYNewViewController.h"
#import "KYTabBar.h"
#import "KYNavigationController.h"

@interface KYTabBarController ()

@end

@implementation KYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置item
    [self setupItem];
    //添加子控制器
    [self setupChildVcs];
    //添加自定义tabBar
    [self setupTabBar];

    
}
- (void)setupTabBar{
    KYTabBar * tabBar = [[KYTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

/**
 *  设置item属性
 */
- (void)setupItem{
    NSMutableDictionary * normalDic = [[NSMutableDictionary alloc]init];
    normalDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    NSMutableDictionary * selectedDic = [[NSMutableDictionary alloc]init];
    selectedDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    selectedDic[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedDic forState:(UIControlStateSelected)];
}
/**
 *  设置子控制器
 */
- (void)setupChildVcs{
    [self setupChildVc:[[KYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[KYNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[KYFriendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[KYMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
/**
 *  添加一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中时图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    KYNavigationController * nav = [[KYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

@end
