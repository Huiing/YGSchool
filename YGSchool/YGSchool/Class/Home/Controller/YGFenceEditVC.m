//
//  YGFenceEditVC.m
//  YGSchool
//
//  Created by faith on 17/3/9.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGFenceEditVC.h"
#import "YGCommon.h"
#import "YGRemindRecevieVC.h"
const static CGFloat cellHeight = 35;
const static CGFloat cellFooterHeight = 20;
@interface YGFenceEditVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *footerView;
@property (nonatomic, strong) NSArray *tableViewTitles;
@property (nonatomic, copy,) NSString               *fenceName;
@property (nonatomic, assign) NSInteger             remindType;

@end

@implementation YGFenceEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"围栏编辑";
    [self.rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
}
- (NSArray*)tableViewTitles{
    if(_tableViewTitles == nil){
        _tableViewTitles = @[@"围栏名字", @"提醒类型", @"接收提醒"];
    }
    return _tableViewTitles;
}
- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"fenceEditCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    NSInteger row = indexPath.row;
    cell.textLabel.text = self.tableViewTitles[row];
    NSString *detailText = @"";
    switch (row) {
        case 0:{
//            detailText = self.fenceName;
            detailText = @"Home";
        }
            break;
            
        case 1:{
            switch (self.remindType) {
                case 0:{
                    detailText = @"进入提醒";
                }
                    break;
                    
                case 1:{
                    detailText = @"出去提醒";
                }
                    break;
            }
        }
            break;
            
        case 2:{
//            NSInteger receiveInterval = self.viewModel.remindRecevieViewModel.receiveInterval + 1;
//            detailText = localizedString([NSString stringWithFormat:@"receiveInterval%d", (int)receiveInterval]);
//            NSInteger receiveTimes = self.viewModel.remindRecevieViewModel.receiveTimes + 1;
//            detailText = [detailText stringByAppendingString:@","];
//            detailText = [detailText stringByAppendingString:localizedString([NSString stringWithFormat:@"receiveTimes%d", (int)receiveTimes])];
            detailText = @"5分钟,1次";

        }
            break;
    }
    cell.detailTextLabel.text = detailText;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return cellFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertView.title = @"围栏名字";
            [alertView addButtonWithTitle:@"确认"];
            [alertView addButtonWithTitle:@"取消"];
            [alertView show];
        }
            break;
            
        case 1:{
            UIActionSheet *sheet = [[UIActionSheet alloc] init];
            sheet.delegate = self;
            [sheet addButtonWithTitle:@"进入提醒"];
            [sheet addButtonWithTitle:@"离开提醒"];
            [sheet addButtonWithTitle:@"提醒"];
            [sheet showInView:self.view];
        }
            break;
            
        case 2:{
            YGRemindRecevieVC *remindRecevieVC = [[YGRemindRecevieVC alloc] init];
            [self presentViewController:remindRecevieVC animated:YES completion:nil];
        }
            break;
    }
}

@end
