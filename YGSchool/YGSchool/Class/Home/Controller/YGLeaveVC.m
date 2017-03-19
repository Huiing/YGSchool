//
//  YGLeaveVC.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGLeaveVC.h"
#import "YGCommon.h"
@interface YGLeaveVC ()<UITableViewDataSource,UITableViewDelegate>
{
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
    YGLeaveShadeView *leaveShadeV;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leaveBills;
@end

@implementation YGLeaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假";
//    self.rightBtn.hidden = YES;
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    if([YGLDataManager manager].userData.userType == UserTypeParent){
//        self.rightBtn.hidden = NO;
//        [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal];
//        [self.rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
    [self.view addSubview:self.tableView];
    [YGShow fullSperatorLine:self.tableView];
    [self queryLeaveBill];
}
- (NSArray *)leaveBills{
    if(!_leaveBills){
        _leaveBills = [[NSArray alloc] init];
    }
    return _leaveBills;
}
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leaveBills.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 105;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YGLeaveListCell";
    YGLeaveListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[YGLeaveListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *dic = self.leaveBills[indexPath.row];
    [cell setDic:dic];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [NSArray array];
    
    if([YGLDataManager manager].userData.userType ==UserTypeParent){
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"点击了删除");
            
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:@"leaveDel" forKey:@"event_code"];
            [parameter setObject:@"" forKey:@"account_id"];
            [parameter setObject:@"" forKey:@"leave_id"];
            [YGNetWorkManager delectLeaveWithParameter:parameter completion:^(id responseObject) {
                NSLog(@"responseObject:%@",responseObject);
            } fail:^{
                
            }];
            [self.tableView reloadData];
            
        }];
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"点击了编辑");
            YGLeaveShadeView *leaveShadeView = [[YGLeaveShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
            leaveShadeV = leaveShadeView;
            __block YGLeaveShadeView *weakLeaveShadeView  = leaveShadeView;
            
            
#warning 请求完数据后根据indexPath获取数据 现在是用假数据
            leaveShadeView.chooseStudentTXF.text = @"测试学生";
            leaveShadeView.chooseDateTXF.text = @"2017-02-09";
            leaveShadeView.leaveDaysTXF.text = @"3天";
            leaveShadeView.reasonTXF.text = @"有事";
            leaveShadeView.chooseStudentBlock = ^{
                YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
                __block YGShadeView *weakShadeView  = shadeView;
                shadeView.titleArray = @[@"选择学生",@"测试学生",@"学生2",@"测试学生45"];
                shadeView.chooseBlock = ^(NSString *title){
                    weakLeaveShadeView.chooseStudentTXF.text = title;
                    [weakShadeView dissmiss];
                };
                [self.view.window addSubview:shadeView];
            };
            leaveShadeView.chooseDateBlock = ^{
                //日期选择
                pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
                pickerView.dateFormat = @"yyyy-MM-dd";
                headView = pickerView.headView;
                
                [headView addTarget:self confirmAction:@selector(confirm:)];
                [headView addTarget:self cancelAction:@selector(cancle:)];
                [weakLeaveShadeView addSubview:pickerView];
                //        pickerView.hidden = YES;
                
            };
            leaveShadeView.clickBlock = ^(NSInteger tag){
                if(tag ==0){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    NSString *alertMessage;
                    if([leaveShadeView.chooseStudentTXF.text length] ==0) {
                        alertMessage = @"请选择学生";
                    }else if([leaveShadeView.chooseDateTXF.text length] ==0){
                        alertMessage = @"请选择请假起始日期";
                    }else if([leaveShadeView.leaveDaysTXF.text length] ==0){
                        alertMessage = @"请选择请假天数";
                    }else if([leaveShadeView.reasonTXF.text length] ==0){
                        alertMessage = @"请选择请假事由";
                    }else{
                        return ;
                    }
                    alert.message = alertMessage;
                    [self presentViewController:alert animated:YES completion:nil];
                    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
                    [parameter setObject:@"leaveEdit" forKey:@"event_code"];
                    [parameter setObject:@"" forKey:@"leave_id"];
                    [parameter setObject:@"" forKey:@"account_id"];
                    [parameter setObject:@"" forKey:@"student_id"];
                    [parameter setObject:@"" forKey:@"date"];
                    [parameter setObject:@"" forKey:@"days"];
                    [parameter setObject:@"" forKey:@"desc"];
                    [YGNetWorkManager editLeaveWithParameter:parameter completion:^(id responseObject) {
                        NSLog(@"responseObject:%@",responseObject);
                    } fail:^{
                        
                    }];
                    
                }else{
                    [weakLeaveShadeView dissmiss];
                }
            };
            [self.view.window addSubview:leaveShadeView];
            
        }];
        editAction.backgroundColor = [UIColor grayColor];
        array = @[deleteAction, editAction];
    }else{
        UITableViewRowAction *approveAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"批准" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"点击了批准");
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:@"leaveAdult" forKey:@"event_code"];
            [parameter setObject:@"" forKey:@"account_id"];
            [parameter setObject:@"" forKey:@"leave_id"];
            [parameter setObject:@"" forKey:@"status"];
            [YGNetWorkManager verifyLeaveWithParameter:parameter completion:^(id responseObject) {
                NSLog(@"responseObject:%@",responseObject);
            } fail:^{
                
            }];
            [self.tableView reloadData];
            
        }];
        approveAction.backgroundColor = [UIColor blueColor];
        array = @[approveAction];
    }
    return array;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
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

- (void)addAction:(UIButton *)sender{
    YGLeaveShadeView *leaveShadeView = [[YGLeaveShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    leaveShadeV = leaveShadeView;
    __block YGLeaveShadeView *weakLeaveShadeView  = leaveShadeView;
    leaveShadeView.chooseStudentBlock = ^{
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"选择学生",@"测试学生",@"学生2",@"测试学生45"];
        shadeView.chooseBlock = ^(NSString *title){
            weakLeaveShadeView.chooseStudentTXF.text = title;
            [weakShadeView dissmiss];
        };
        [self.view.window addSubview:shadeView];
    };
    leaveShadeView.chooseDateBlock = ^{
        //日期选择
        pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
        pickerView.dateFormat = @"yyyy-MM-dd";
        headView = pickerView.headView;
        
        [headView addTarget:self confirmAction:@selector(confirm:)];
        [headView addTarget:self cancelAction:@selector(cancle:)];
        [weakLeaveShadeView addSubview:pickerView];
//        pickerView.hidden = YES;

    };
    leaveShadeView.clickBlock = ^(NSInteger tag){
        if(tag ==0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            NSString *alertMessage;
            if([leaveShadeView.chooseStudentTXF.text length] ==0) {
                alertMessage = @"请选择学生";
            }else if([leaveShadeView.chooseDateTXF.text length] ==0){
                alertMessage = @"请选择请假起始日期";
            }else if([leaveShadeView.leaveDaysTXF.text length] ==0){
                alertMessage = @"请选择请假天数";
            }else if([leaveShadeView.reasonTXF.text length] ==0){
                alertMessage = @"请选择请假事由";
            }else{
                return ;
            }
            alert.message = alertMessage;
            [self presentViewController:alert animated:YES completion:nil];
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:@"leaveAdd" forKey:@"event_code"];
            [parameter setObject:@"" forKey:@"account_id"];
            [parameter setObject:@"" forKey:@"student_id"];
            [parameter setObject:@"" forKey:@"date"];
            [parameter setObject:@"" forKey:@"days"];
            [parameter setObject:@"" forKey:@"desc"];
            [YGNetWorkManager addLeaveWithParameter:parameter completion:^(id responseObject) {
                    NSLog(@"responseObject:%@",responseObject);
                
            } fail:^{
                
            }];
            
        }else{
            [weakLeaveShadeView dissmiss];
        }
    };
    [self.view.window addSubview:leaveShadeView];
}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *resultStr = pickerView.resultStr;
    if (resultStr == nil) {
        resultStr = dateStr;
    }
    leaveShadeV.chooseDateTXF.text = resultStr;
    pickerView.hidden = YES;
    
}
- (void)cancle:(UIButton *)sender {
    pickerView.hidden = YES;
}
- (void)queryLeaveBill{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"leaveSearch" forKey:@"event_code"];
    [dic setObject:@"" forKey:@"account_id"];
    [dic setObject:@"" forKey:@"class_id"];
    [dic setObject:@"" forKey:@"student_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager queryLeaveWithParameter:parameter completion:^(id responseObject) {
        if([responseObject[@"code"] integerValue] ==1){
            self.leaveBills = responseObject[@"dt"];
            [self.tableView reloadData];
        }
    } fail:^{
        
    }];
}
@end
