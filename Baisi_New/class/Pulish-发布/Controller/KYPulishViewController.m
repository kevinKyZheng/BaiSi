//
//  KYPulishViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/20.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYPulishViewController.h"
#import "KYPulishButton.h"
#import <POP.h>
#import "KYPostWordViewController.h"
static CGFloat const KYSpringFactor = 10;
@interface KYPulishViewController ()
@property(nonatomic,strong)NSMutableArray * buttons;
@property(nonatomic,strong)NSArray * times;
@property(nonatomic,weak)UIImageView * slogenView;

@end

@implementation KYPulishViewController
#pragma mark 懒加载
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSArray *)times{
    if (_times == nil) {
        CGFloat timeInterval = 0.1;
        _times = @[@(5 * timeInterval),
                   @(4 * timeInterval),
                   @(3 * timeInterval),
                   @(2 * timeInterval),
                   @(1 * timeInterval),
                   @(0 * timeInterval),
                   @(6 * timeInterval)];
    }
    return _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    [self setupButtons];
    [self setupSlogenView];
    
}
/**
 *  button
 */
- (void)setupButtons{
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    //相关参数
    int numOfColumn = 3;
    NSUInteger count = images.count;
    NSInteger numOfRow = (count + numOfColumn - 1)/numOfColumn;
    //尺寸
    CGFloat buttonW = KYScreenW / numOfColumn;
    CGFloat buttonH = buttonW;
    CGFloat startY = (KYScreenH - numOfRow * buttonH) * 0.5;
    for (int i =0; i < count; i++) {
        //初始化button
        KYPulishButton * publishBtn = [KYPulishButton buttonWithType:(UIButtonTypeCustom)];
        [self.buttons addObject:publishBtn];
        [self.view addSubview:publishBtn];
        [publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [publishBtn setTitle:titles[i] forState:(UIControlStateNormal)];
        [publishBtn setImage:[UIImage imageNamed:images[i]] forState:(UIControlStateNormal)];
        //设置frame
        CGFloat buttonX = (i % numOfColumn) * buttonW;
        CGFloat buttonY = (i / numOfColumn) * buttonH + startY;
        //动画
        POPSpringAnimation * ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        ani.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX,buttonY - KYScreenH, buttonW, buttonH)];
        ani.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX,buttonY, buttonW, buttonH)];
        ani.springBounciness = KYSpringFactor;
        ani.springSpeed = KYSpringFactor;
        ani.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [publishBtn pop_addAnimation:ani forKey:nil];
    }
}
/**
 *  slogen
 */
- (void)setupSlogenView{
    CGFloat slogenY = KYScreenH * 0.2;
    UIImageView * slogenView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [slogenView sizeToFit];
    slogenView.centerX = KYScreenW * 0.5;
    slogenView.y = slogenY - KYScreenH;
    [self.view addSubview:slogenView];
    self.slogenView = slogenView;
    
    //动画
    POPSpringAnimation * ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    ani.toValue = @(slogenY);
    ani.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    ani.springSpeed = KYSpringFactor;
    ani.springBounciness = KYSpringFactor;
    [ani setCompletionBlock:^(POPAnimation * ani, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    [slogenView.layer pop_addAnimation:ani forKey:nil];
}
/**
 *  按钮点击事件
 */
- (void)publishBtnClick:(KYPulishButton *)button{
    [self exit:^{
        NSUInteger index = [self.buttons indexOfObject:button];
        switch (index) {
            case 2:{
                KYPostWordViewController * postVc = [[KYPostWordViewController alloc]init];
                [self.view.window.rootViewController presentViewController:[[UINavigationController alloc]initWithRootViewController:postVc] animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }];
}
/**
 *  取消事件
 */
- (void)exit:(void(^)())task{
    self.view.userInteractionEnabled = NO;
    //按钮退出
    for (int i = 0; i < self.buttons.count; i++) {
        KYPulishButton * pulishBtn = self.buttons[i];
        POPSpringAnimation * ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        ani.toValue = @(pulishBtn.layer.position.y + KYScreenH);
        ani.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [pulishBtn.layer pop_addAnimation:ani forKey:nil];
    }
    //标题退出
    KYWeakSelf
    POPSpringAnimation * ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    ani.toValue = @(self.slogenView.layer.position.y + KYScreenH);
    ani.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    [ani setCompletionBlock:^(POPAnimation * ani, BOOL finished) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        !task ? :task();
    }];
    [self.slogenView.layer pop_addAnimation:ani forKey:nil];
    
}

- (IBAction)backBtnClick:(id)sender {
    [self exit:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self exit:nil];
}

@end
