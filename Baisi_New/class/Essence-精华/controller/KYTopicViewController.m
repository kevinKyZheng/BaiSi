//
//  KYTopicViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/9/22.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYTopicViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "KYTopicCell.h"
#import "KYTopic.h"
#import <MJExtension.h>
#import "KYNewViewController.h"
#import "KYCommentViewController.h"
@interface KYTopicViewController ()
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSMutableArray * topics;
@property (nonatomic,copy)NSString * maxtime;

@end
static NSString * const KYTopicCellId = @"TopicCell";

@implementation KYTopicViewController
//消除警告,子类会覆盖
-(KYTopicType)type{return 0;}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
}
- (void)setupTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(KYNavBarMaxY+KYTitleViewH, 0, KYTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KYBgColor;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYTopicCell class]) bundle:nil] forCellReuseIdentifier:KYTopicCellId];
    
}
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}
- (NSString *)aParam
{
    // [a isKindOfClass:c] 判断a是否为c类型或者c的子类类型
    if ([self.parentViewController isKindOfClass:[KYNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}
- (void)loadNewTopics{
   [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //请求参数
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    KYWeakSelf
    [self.manager GET:KYRequestURL parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        weakSelf.topics = [KYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [weakSelf.tableView reloadData];
        //停止刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //停止刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreTopics{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    KYWeakSelf
    [self.manager GET:KYRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray * moreTopics = [KYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:moreTopics];
        //储存下一页的信息
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [weakSelf.tableView reloadData];
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //停止刷新
        [self.tableView.mj_footer endRefreshing];

    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}
- (KYTopicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:KYTopicCellId];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
#pragma mark tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYTopic * topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KYCommentViewController * commentVc = [[KYCommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}
@end
