//
//  YGNoticeDetailVC.m
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGNoticeDetailVC.h"
#import "YGCommon.h"
@interface YGNoticeDetailVC ()
@property(nonatomic, strong)UILabel *contentLbl;
@property(nonatomic, strong)UIImageView *imageView;
@end

@implementation YGNoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    self.rightBtn.hidden = YES;
    [self addSubViews];
}
- (void)addSubViews{
    self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 20)];
    self.contentLbl.text = @"测试红点";
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth - 20, 100)];
    self.imageView.image = [UIImage imageNamed:@"i4"];
    [self.view addSubview:self.contentLbl];
    [self.view addSubview:self.imageView];
}

@end
