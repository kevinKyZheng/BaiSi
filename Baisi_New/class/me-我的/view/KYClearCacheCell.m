//
//  KYClearCacheCell.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/19.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYClearCacheCell.h"
#import "NSString+KYFileCache.h"
#import <SVProgressHUD.h>

@implementation KYClearCacheCell

static NSString * const KYDefaultText = @"清除缓存";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = KYDefaultText;
        
        self.userInteractionEnabled = NO;
        
        UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [loadingView startAnimating];
        self.accessoryView = loadingView;

        [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
            NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            NSInteger size = filePath.fileCache;
            NSString * sizeText = nil;
            CGFloat unit = 1000.0;
            if (size >= unit * unit * unit) {
                sizeText = [NSString stringWithFormat:@"%.1fGB",size / unit / unit /unit];
            }else if (size >= unit * unit){
                sizeText = [NSString stringWithFormat:@"%0.1fMB",size / unit/ unit];
            }else if (size >= unit){
                sizeText = [NSString stringWithFormat:@"%0.1fKB",size / unit];
            }else{
                sizeText = [NSString stringWithFormat:@"%ldB",(long)size];
            }
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.textLabel.text = [NSString stringWithFormat:@"%@:%@",KYDefaultText,sizeText];
                self.accessoryView = nil;
                self.userInteractionEnabled = YES;
            }];
        }];
        
    }
    return self;
}
- (void)clearCache{
    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    [[NSOperationQueue currentQueue]addOperationWithBlock:^{
        [[NSFileManager defaultManager]removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] error:nil];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            self.textLabel.text = KYDefaultText;
            self.userInteractionEnabled = NO;
        }];
    }];
}
- (void)updateStatus{
    if (self.accessoryView == nil) return;
    UIActivityIndicatorView * loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}
@end
