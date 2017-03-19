//
//  YGRewardPunishmentVC.m
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGRewardPunishmentVC.h"
#import "YGCommon.h"
@interface YGRewardPunishmentVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *rewardTable;
@property(nonatomic,strong) UITableView *punishmentTable;
@end

@implementation YGRewardPunishmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖励和惩罚";
    self.backView.hidden = YES;
    self.chooseControl.titleArray = @[@"奖励",@"惩罚"];
    __block YGRewardPunishmentVC *weakSelf = self;
    self.chooseControl.switchBlock = ^(NSInteger tag){
        if(tag ==0){
            weakSelf.rewardTable.hidden = NO;
            weakSelf.punishmentTable.hidden = YES;
        }else{
            weakSelf.rewardTable.hidden = YES;
            weakSelf.punishmentTable.hidden = NO;
        }
    };

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, kScreenWidth, 1)];
    lineView.backgroundColor = COLOR(200, 200, 200, 1);
    [self.view addSubview:lineView];
    [self.view addSubview:self.rewardTable];
    [self.view addSubview:self.punishmentTable];
    [YGShow fullSperatorLine:self.rewardTable];
    [YGShow fullSperatorLine:self.punishmentTable];
    self.punishmentTable.hidden = YES;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![YGLDataManager manager].userData.login){
        YGLoginVC *loginVC = [[YGLoginVC alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

}

- (UITableView *)rewardTable{
    if(!_rewardTable){
        _rewardTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight-76) style:UITableViewStylePlain];
        _rewardTable.tag = 0;
        _rewardTable.delegate = self;
        _rewardTable.dataSource = self;
        _rewardTable.tableFooterView = [[UIView alloc] init];
    }
    return _rewardTable;
}
- (UITableView *)punishmentTable{
    if(!_punishmentTable){
        _punishmentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight-76) style:UITableViewStylePlain];
        _punishmentTable.tag = 1;
        _punishmentTable.delegate = self;
        _punishmentTable.dataSource = self;
        _punishmentTable.tableFooterView = [[UIView alloc] init];
    }
    return _punishmentTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag ==0){
        return 44;
    }
    return 65;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag ==0){
        static NSString *identify = @"YGNoticeListCell";
        YGNoticeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell){
            cell = [[YGNoticeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
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
    YGRewardPunishmentDetailVC *vc = [[YGRewardPunishmentDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
- (void)queryRewardList{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"rewardSearch" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [YGNetWorkManager queryRewardListWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
- (void)queryPunishmentList{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"punishSearch" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [YGNetWorkManager querypunishmentListWithParameter:parameter completion:^(id responseObject) {
        
    } fail:^{
        
    }];
}
@end
