//
//  YGStudentListVC.m
//  YGSchool
//
//  Created by faith on 17/3/6.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGStudentListVC.h"
#import "YGCommon.h"
@interface YGStudentListVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation YGStudentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"学生列表";
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (void)getStudentList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"studentList" forKey:@"event_code"];
    [dic setObject:@"" forKey:@"account_id"];
    [dic setObject:@"" forKey:@"class_id"];
    [YGNetWorkManager getStudentListWithParameter:dic completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        NSLog(@"");
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = @"小华";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YGGPSVC *vc = [[YGGPSVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
