//
//  KYCommentViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 2016/10/15.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYCommentViewController.h"
#import "KYCommentCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "KYTopic.h"
#import "KYComment.h"
#import "KYTopicCell.h"


@interface KYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSMutableArray * lastComments;


@end

@implementation KYCommentViewController
static NSString * const KYCommentCellID = @"comment";
static NSString * const KYCommentCellHeaderID = @"commentHeader";

#pragma mark 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self setupRefresh];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:(UIKeyboardWillChangeFrameNotification) object:nil];
}
- (void)setupNav{
    self.title = @"评  论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    UIFont * font = [UIFont systemFontOfSize:22];
    NSDictionary * dic = @{NSFontAttributeName:font};
    self.navigationController.navigationBar.titleTextAttributes = dic;
}
- (void)setupTableView{
    self.tableView.backgroundColor = KYBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYCommentCell class]) bundle:nil] forCellReuseIdentifier:KYCommentCellID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:KYCommentCellHeaderID];
    //设置行高
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //设置header
    KYTopicCell * topicCell = [KYTopicCell viewFromXib];
    topicCell.topic = self.topic;
    topicCell.frame = CGRectMake(0, 0, KYScreenW, self.topic.cellHeight);

    UIView * headerView = [[UIView alloc]init];
    headerView.height = topicCell.height + 2 * KYCommonMargin;
    [headerView addSubview:topicCell];
    
    self.tableView.tableHeaderView = headerView;
}
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRequest)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRequest)];
}
#pragma mark 上拉下拉刷新
- (void)loadNewRequest{

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    KYWeakSelf
    [self.manager GET:KYRequestURL parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //无评论
        if ([responseObject isKindOfClass:([NSArray class])]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        //最新评论
        weakSelf.lastComments = [KYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        //评论加载完毕
        if (weakSelf.lastComments.count >= [responseObject[@"total"] intValue]) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        //停止刷新
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }] ;
}

- (void)loadMoreRequest{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.lastComments.lastObject ID];

    KYWeakSelf
    [self.manager GET:KYRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * newComment = [KYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.lastComments addObjectsFromArray:newComment];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        //加载了全部的评论,隐藏footer
        if ((weakSelf.lastComments.count + 10)>= [responseObject[@"total"] intValue]) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark 监听键盘变化
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    
    self.bottomLayout.constant = KYScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark tableview Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark tableview DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.lastComments.count) return 1;
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lastComments.count;
}
-(KYCommentCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KYCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:KYCommentCellID];
    commentCell.comment = self.lastComments[indexPath.row];
    return commentCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KYCommentCellHeaderID];
    headerView.textLabel.text = @"最新评论";
    return headerView;
}
@end
