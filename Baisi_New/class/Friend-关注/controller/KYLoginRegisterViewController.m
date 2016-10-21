//
//  KYLoginRegisterViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/10.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYLoginRegisterViewController.h"

@interface KYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@end

@implementation KYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
/**
 *  点击屏幕 退键盘
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)RegistClick:(UIButton *)sender {
    if (self.leftSpace.constant == 0) {
        self.leftSpace.constant = - self.view.width;
        sender.selected = YES;
    }else{
        self.leftSpace.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
//        修改约束
        [self.view layoutIfNeeded];
    }];
}
@end
