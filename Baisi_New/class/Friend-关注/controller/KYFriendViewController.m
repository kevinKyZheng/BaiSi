//
//  KYFriendViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/5/17.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYFriendViewController.h"
#import "KYLoginRegisterViewController.h"

@interface KYFriendViewController ()

@end

@implementation KYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KYBgColor;
}
- (IBAction)loginRegist {
    KYLoginRegisterViewController * loginVc = [[KYLoginRegisterViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
}



@end
