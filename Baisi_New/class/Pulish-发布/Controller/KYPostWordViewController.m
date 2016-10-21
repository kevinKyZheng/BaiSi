//
//  KYPostWordViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/20.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYPostWordViewController.h"
#import "KYPlaceHolderTextView.h"
#import "KYToolbarView.h"

@interface KYPostWordViewController ()<UITextViewDelegate>
@property(nonatomic,weak)KYPlaceHolderTextView * textView;
@property(nonatomic,weak)KYToolbarView * toolBarView;
@end

@implementation KYPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupTextView];
    [self setupToolBar];
}
- (void)setupNav{
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:(UIBarButtonItemStyleDone) target:self action:@selector(publish)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
- (void)setupTextView{
    KYPlaceHolderTextView * textView = [[KYPlaceHolderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理.";
    self.textView = textView;
    [self.view addSubview:textView];
}
- (void)setupToolBar{
    KYToolbarView * toolBarView = [KYToolbarView viewFromXib];
    toolBarView.x = 0;
    toolBarView.y = self.view.height - toolBarView.height;
    toolBarView.width = self.view.width;
    self.toolBarView = toolBarView;
    [self.view addSubview:toolBarView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
//监听键盘改变
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGFloat duration = [[note.userInfo valueForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [[note.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
        self.toolBarView.transform = CGAffineTransformMakeTranslation(0,ty- KYScreenH);
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.textView resignFirstResponder];
}
//NavigationItem 左右两边的Item
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)publish{
    
}
#pragma mark  textView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}
- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
@end
