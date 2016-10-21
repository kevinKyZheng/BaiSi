//
//  KYTagViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/11.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTagViewController.h"
#import <AFNetworking.h>
#import "KYTagCell.h"
#import <SVProgressHUD.h>
#import "MJExtension.h"
#import "KYTag.h"

@interface KYTagViewController ()
@property(nonatomic,weak)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSArray * tags;

@end

//cell的循环标示
static NSString * const CellId = @"tag";

@implementation KYTagViewController
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐标签";
    
    [self setupTableView];
    
    [self loadTag];
}
/**
 *  设置表格属性
 */
- (void)setupTableView{
    self.tableView.backgroundColor = KYBgColor;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYTagCell class]) bundle:nil] forCellReuseIdentifier:CellId];
}
/**
 *  加载数据
 */
- (void)loadTag{
    [SVProgressHUD show];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    KYWeakSelf;
    [weakSelf.manager GET:KYRequestURL parameters:params success:^(NSURLSessionDataTask * task, NSArray * responseObject) {

        if (responseObject == nil) {
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return;
        }
        weakSelf.tags = [KYTag objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载完毕"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //用户取消网络请求,不算错误
        if (error.code == NSURLErrorCancelled) return ;
        if (error.code == NSURLErrorTimedOut) {
            [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}
- (void)dealloc
{
    //控制器销毁时,取消网络请求
    [self.manager invalidateSessionCancelingTasks:YES];
    [SVProgressHUD dismiss];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYTagCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.tagModel = self.tags[indexPath.row];
    return cell;
}

@end
