//
//  KYMeViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/5/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYMeViewController.h"
#import "KYSettingViewController.h"
#import "KYMeCell.h"
#import "KYMeFooter.h"
#import "KYLoginRegisterViewController.h"
@interface KYMeViewController ()

@end

@implementation KYMeViewController
//cellID
static NSString * const KYMeCellId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableview];
}
/**
 *  初始化导航栏
 */
- (void)setupNav{
    self.navigationItem.title = @"我的";
    // 导航栏右边的内容
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}
- (void)moonClick{
    
}
- (void)settingClick{
    KYSettingViewController * settingVc = [[KYSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
/**
 *  初始化Tableview
 */
- (void)setupTableview{
    self.tableView.backgroundColor = KYBgColor;
    
    [self.tableView registerClass:[KYMeCell class] forCellReuseIdentifier:KYMeCellId];
    self.tableView.contentInset = UIEdgeInsetsMake(KYCommonMargin, 0, 100, 0);
    
    self.tableView.tableFooterView = [[KYMeFooter alloc]init];
}
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (KYMeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYMeCell * cell = [tableView dequeueReusableCellWithIdentifier:KYMeCellId];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登陆/注册";
        cell.textLabel.textColor = [UIColor blackColor];
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下载";
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self presentViewController:[[KYLoginRegisterViewController alloc]init]animated:YES completion:nil];
    }
}
#pragma mark TableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return KYCommonMargin;
}
@end
