//
//  YGShadeView.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGShadeView.h"
#import "YGCommon.h"
@interface YGShadeView()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation YGShadeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self addSubViews];
}
- (void)addSubViews{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 80, kScreenWidth-60, 400)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 7;
    [view1.layer setMasksToBounds:YES];
    [self addSubview:view1];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 400) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [view1 addSubview:self.tableView];
    [YGShow fullSperatorLine:self.tableView];
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 490, kScreenWidth - 60, 30)];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:[UIColor whiteColor]];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancleBtn.layer.cornerRadius = 7;
    [cancleBtn.layer setMasksToBounds:YES];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
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
    
    if(self.chooseBlock){
        self.chooseBlock(sender.titleLabel.text);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.titleArray[indexPath.row];
    if(indexPath.row != 0){
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = BG_COLOR;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0){
        return 40;
    }
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row !=0){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *title = cell.textLabel.text;
        if(self.chooseBlock){
            self.chooseBlock(title);
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 补全分割线
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
