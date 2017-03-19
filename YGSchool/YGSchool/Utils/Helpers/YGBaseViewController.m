//
//  YGBaseViewController.m
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBaseViewController.h"
#import "YGCommon.h"

@interface YGBaseViewController ()

@end

@implementation YGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
//    [self initCustomTitleView];

}
- (void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-10, 15, 100, 39)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 15, 15)];
    imageView.image = [UIImage imageNamed:@"previous"];
    [backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 9, 40, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = @"返回";
    [backView addSubview:label];
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [b addTarget:self action:@selector(bAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:b];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-50, 24, 40, 20)];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.rightBtn.layer.cornerRadius = 7;
    [self.rightBtn.layer setMasksToBounds:YES];
    
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.rightBtn setBackgroundColor:COLOR_WITH_HEX(0x0f5378)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = COLOR_WITH_HEX(0x814b20);
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationController.navigationBar.barTintColor = COLOR_WITH_HEX(0xeb893b);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
}
- (void)initCustomTitleView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * tmpStr1 = NSStringFromClass([self class]);
    NSString * tmpStr2 = @"YGHomeVC";
    NSString * tmpStr3 = @"YGRegisterVC";

    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    self.titleView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.titleView];
    self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 , kScreenWidth, 39)];
    self.titleLbl.backgroundColor = [UIColor clearColor];
    self.titleLbl.font = [UIFont boldSystemFontOfSize:16];
    self.titleLbl.textColor = [UIColor whiteColor];
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.titleLbl];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 100, 39)];
    [self.titleView addSubview:self.backView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 11, 15, 15)];
    imageView.image = [UIImage imageNamed:@"previous"];
    [self.backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 40, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = @"返回";
    [self.backView addSubview:label];
    
    // 防止与个别界面的手势发生冲突
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [b addTarget:self action:@selector(bAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:b];

    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-50, 24, 40, 20)];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.rightBtn.layer.cornerRadius = 7;
    [self.rightBtn.layer setMasksToBounds:YES];

    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.rightBtn setBackgroundColor:COLOR_WITH_HEX(0x0f5378)];
    [self.titleView addSubview:self.rightBtn];
    if([tmpStr1 isEqualToString:tmpStr2]==YES){
        self.titleView.height = 30;
        self.backView.hidden = YES;
        self.rightBtn.hidden = YES;
    }else if([tmpStr1 isEqualToString:tmpStr3]==YES){
        self.titleView.height = 60;
        self.titleLbl.top = 15;
        self.backView.top = 15;
        self.rightBtn.hidden = YES;
    }
}

- (void)bAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
