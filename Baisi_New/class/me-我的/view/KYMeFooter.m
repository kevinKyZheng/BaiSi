//
//  KYMeFooter.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/12.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYMeFooter.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "KYSquare.h"
#import "KYSquareButton.h"
#import "KYWebViewController.h"

@implementation KYMeFooter

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        KYWeakSelf;
        [[AFHTTPSessionManager manager]GET:KYRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSLog(@"%@",[KYSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]]);
            [weakSelf creatSquare:[KYSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}
- (void)creatSquare:(NSArray *)squares{
    //列数
    int columnCount = 4;
    //按钮的长和宽
    CGFloat btnW = self.width / columnCount;
    CGFloat btnH = btnW;
    
    for (NSInteger i = 0; i < squares.count; i++) {
        KYSquareButton * SquareBtn = [KYSquareButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:SquareBtn];
        [SquareBtn addTarget:self action:@selector(SquareBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        CGFloat btnX = (i % columnCount) * btnW;
        CGFloat btnY = (i / columnCount) * btnH;
        SquareBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //设置数据
        SquareBtn.square = squares[i];
        //设置footer高度
        self.height = CGRectGetMaxY(SquareBtn.frame);
    }
    UITableView * tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
//    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
}
- (void)SquareBtnClick:(KYSquareButton *)button{
    if ([button.square.url hasPrefix:@"http"] == NO) return;
    KYWebViewController * webVc = [[KYWebViewController alloc]init];
    webVc.square = button.square;
    //
    UITabBarController * tabBarVc = (UITabBarController *) self.window.rootViewController;
    UINavigationController * nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:webVc animated:YES];
    
}
@end
