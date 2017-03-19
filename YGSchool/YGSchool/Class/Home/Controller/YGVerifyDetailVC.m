//
//  YGVerifyDetailVC.m
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGVerifyDetailVC.h"
#import "YGCommon.h"
@interface YGVerifyDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *statusBtn;
@property(nonatomic, strong)NSArray *dataArray;
@end

@implementation YGVerifyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核详情";
    self.rightBtn.hidden = YES;
    self.dataArray = @[@"姓名: ",@"与学生关系: ",@"学生姓名: ",@"学生学号: ",@"联系方式: ",@"状态: "];
    [self.view addSubview:self.tableView];
    [YGShow fullSperatorLine:self.tableView];
    [self.view addSubview:self.statusBtn];
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (UIButton *)statusBtn{
    if(!_statusBtn){
        _statusBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 326, kScreenWidth-40, 35)];
        _statusBtn.layer.cornerRadius = 7;
        [_statusBtn.layer setMasksToBounds:YES];
        [_statusBtn setBackgroundColor:COLOR_WITH_HEX(0xb8b8b8)];
        [_statusBtn setTitle:@"通过审核" forState:UIControlStateNormal];
        [_statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _statusBtn;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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