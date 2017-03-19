//
//  YGChooseUserTypeView.m
//  YGSchool
//
//  Created by faith on 17/2/18.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGChooseUserTypeView.h"
#import "YGCommon.h"
@implementation YGChooseUserTypeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 80, kScreenWidth-60, 400)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 7;
    [view1.layer setMasksToBounds:YES];
    [self addSubview:view1];
    UILabel *titleDesLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth - 60, 20)];
    titleDesLbl.textAlignment = NSTextAlignmentCenter;
//    titleDesLbl.textColor = [UIColor blackColor];
    titleDesLbl.text = @"请选择用户类型";
    [view1 addSubview:titleDesLbl];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 80, 1)];
    line1.backgroundColor = COLOR(236, 236, 236, 1);
    [view1 addSubview:line1];
    
    UIButton *parentBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 45, kScreenWidth - 80, 20)];
    [parentBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    parentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [parentBtn setTitle:@"家长" forState:UIControlStateNormal];
    [parentBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:parentBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, 66, kScreenWidth - 80, 1)];
    line2.backgroundColor = COLOR(236, 236, 236, 1);
    [view1 addSubview:line2];
    UIButton *teacherBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 72, kScreenWidth - 80, 20)];
    [teacherBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    teacherBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [teacherBtn setTitle:@"教师" forState:UIControlStateNormal];
    [teacherBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:teacherBtn];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(10, 97, kScreenWidth - 80, 1)];
    line3.backgroundColor = COLOR(236, 236, 236, 1);
    [view1 addSubview:line3];

    
    
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 490, kScreenWidth - 60, 30)];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:[UIColor whiteColor]];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancleBtn.layer.cornerRadius = 7;
    [cancleBtn.layer setMasksToBounds:YES];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
//    [self.view.window addSubview:backgroundView];
    [UIView animateWithDuration:0.5 animations:^{
        self.top = 0;
    }];
}
- (void)cancleAction:(UIButton *)sender{
    [self dissmiss];
}
- (void)dissmiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.top = kScreenHeight;
    }];
}
- (void)chooseAction:(UIButton *)sender{
    
    if(self.chooseUserTypeBlock){
        self.chooseUserTypeBlock(sender.titleLabel.text);
    }
}
@end
