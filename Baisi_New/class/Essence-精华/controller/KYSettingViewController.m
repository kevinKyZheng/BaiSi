//
//  KYSettingViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/9.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYSettingViewController.h"
#import "KYClearCacheCell.h"

@interface KYSettingViewController ()

@end

@implementation KYSettingViewController
static NSString * const KYClearCacheCellId = @"clearCache";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.tableView.backgroundColor = KYBgColor;
    [self.tableView registerClass:[KYClearCacheCell class] forCellReuseIdentifier:KYClearCacheCellId];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYClearCacheCell * cell = [tableView dequeueReusableCellWithIdentifier:KYClearCacheCellId];
    [cell updateStatus];
    return cell;
}
#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KYClearCacheCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell clearCache];
    
}
@end
