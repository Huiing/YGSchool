//
//  YGNoticeVC.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGNoticeVC.h"
#import "YGCommon.h"
#import "YGNoticeListCell.h"
#import "YGVerifyCell.h"
#import "YGNoticeDetailVC.h"
#import "YGVerifyDetailVC.h"
@interface YGNoticeVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *noticeTable;
@property(nonatomic,strong) UITableView *verifyTable;
@property(nonatomic,strong) NSArray *noticeList;
@end

@implementation YGNoticeVC
- (NSArray *)noticeList{
    if(!_noticeList){
        _noticeList = [[NSMutableArray alloc] init];
    }
    return _noticeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告通知";
    self.chooseControl.titleArray = @[@"通知",@"审核"];
    __block YGNoticeVC *weakSelf = self;
    self.chooseControl.switchBlock = ^(NSInteger tag){
        if(tag ==0){
            weakSelf.noticeTable.hidden = NO;
            weakSelf.verifyTable.hidden = YES;
        }else{
            weakSelf.noticeTable.hidden = YES;
            weakSelf.verifyTable.hidden = NO;
        }
    };
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, kScreenWidth, 1)];
    lineView.backgroundColor = COLOR(200, 200, 200, 1);
    [self.view addSubview:lineView];
    [self.view addSubview:self.noticeTable];
    [self.view addSubview:self.verifyTable];
    [YGShow fullSperatorLine:self.noticeTable];
    [YGShow fullSperatorLine:self.verifyTable];
    self.verifyTable.hidden = YES;
    [self queryNoticeList];
}
- (UITableView *)noticeTable{
    if(!_noticeTable){
        _noticeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight-76) style:UITableViewStylePlain];
        _noticeTable.tag = 0;
        _noticeTable.delegate = self;
        _noticeTable.dataSource = self;
        _noticeTable.tableFooterView = [[UIView alloc] init];
    }
    return _noticeTable;
}
- (UITableView *)verifyTable{
    if(!_verifyTable){
        _verifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight-76) style:UITableViewStylePlain];
        _verifyTable.tag = 1;
        _verifyTable.delegate = self;
        _verifyTable.dataSource = self;
        _verifyTable.tableFooterView = [[UIView alloc] init];
    }
    return _verifyTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag ==0){
        return 60;
    }
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag ==0){
        static NSString *identify = @"YGNoticeListCell";
        YGNoticeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell){
            cell = [[YGNoticeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        NSDictionary *dic = self.noticeList[indexPath.row];
        [cell setDic:dic];
        return cell;
    }else{
        static NSString *identify = @"YGVerifyCell";
         YGVerifyCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell){
            cell = [[YGVerifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        return cell;

    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    if(tableView.tag ==0){
        vc = [[YGNoticeDetailVC alloc] init];
        YGNoticeDetailVC *noticeDetailVC = (YGNoticeDetailVC *)vc;
        noticeDetailVC.dic = self.noticeList[indexPath.row];
    }else{
        vc = [[YGVerifyDetailVC alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES ];
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
- (void)queryNoticeList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"noticeSearch" forKey:@"event_code"];
    [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
    [dic setObject:[YGLDataManager manager].userData.schoolID forKey:@"school_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];

    [YGNetWorkManager querynoticelistWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        if([responseObject[@"code"] integerValue
            ] ==1){
            self.noticeList = responseObject[@"list"];
            [self.noticeTable reloadData];
        }
    } fail:^{
        
    }];
}
- (void)queryVerifyList{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"noticeSearch" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"school_id"];
    [YGNetWorkManager querynoticelistWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];

}
@end
