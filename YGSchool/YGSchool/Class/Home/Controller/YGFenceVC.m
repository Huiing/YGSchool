//
//  YGFenceVC.m
//  YGSchool
//
//  Created by faith on 17/3/9.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGFenceVC.h"
#import "YGCommon.h"
//cont
const static CGFloat celleHeight = 50;
const static CGFloat cellHeadViewHeight = 40;
@interface YGFenceVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL isEdit;
}
@property (nonatomic, strong) UIButton                  *headView;
@property (nonatomic, strong) UITableView               *tableView;

@end

@implementation YGFenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"电子围栏";
    [self.rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableView];
}
- (UIButton*)headView{
    if(_headView == nil){
        CGFloat headHeight = cellHeadViewHeight;
        _headView = [UIButton buttonWithType:UIButtonTypeCustom];
        _headView.backgroundColor = [UIColor lightGrayColor];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(10, 0, self.view.frame.size.width - 10*2, headHeight);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.text = @"电子围栏";
        [_headView addSubview:textLabel];
        CGFloat imageLenth = 20;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((self.view.frame.size.width - imageLenth - 15), (headHeight - imageLenth)/2, imageLenth, imageLenth);
        imageView.image = [UIImage imageNamed:@"plusIcon"];
        imageView.backgroundColor = [UIColor clearColor];
        [_headView addSubview:imageView];
//        @weakify(self);
//        [[_headView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            @strongify(self);
//            fenceEditViewController *ctrl = [[fenceEditViewController alloc] init];
//            ctrl.title = localizedString(@"createFence");
//            ctrl.deviceID = self.deviceID;
//            ctrl.isCreate = YES;
//            [self.navigationController pushViewController:ctrl animated:YES];
//        }];
    }
    return _headView;
}

- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"fenceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBK"]];
        cell.backgroundView = backgroundView;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    NSInteger row = indexPath.row;
//    NSDictionary *dic = self.viewModel.fences[row]; 
//    NSString *name = dic[@"name"];
    NSString *name = @"Home";
//    BOOL fenceEnable = [dic[@"status"] boolValue];
    BOOL fenceEnable = YES;
    cell.textLabel.text = name;
    
    NSString *detialText = @"";
//    NSDictionary *alarmDic = dic[@"alarm"];
//    NSInteger alarmType = [alarmDic[@"alarm_type"] integerValue];
    NSInteger alarmType = 1;
    switch (alarmType) {
        case 1:
//            detialText = localizedString(@"inRemind");
            detialText = @"进入提醒";
            break;
            
        case 2:
//            detialText = localizedString(@"outRemind");
            detialText = @"离开提醒";
            break;
    }
//    NSString *smsNum = alarmDic[@"by_sms"];
//    NSString *emailAddress = alarmDic[@"by_email"];
//    NSString *callNum = alarmDic[@"by_call"];
//    if(smsNum.length > 0){
//        detialText = [NSString stringWithFormat:@"%@,%@", detialText, localizedString(@"receiveWay1")];
//    }else if(emailAddress.length > 0){
//        detialText = [NSString stringWithFormat:@"%@,%@", detialText, localizedString(@"receiveWay2")];
//    }else if(callNum.length > 0){
//        detialText = [NSString stringWithFormat:@"%@,%@", detialText, localizedString(@"receiveWay3")];
//    }
//    NSInteger rate = [alarmDic[@"rate"] integerValue];
//    detialText = [NSString stringWithFormat:@"%@,%ld%@", detialText, (long)rate, localizedString(@"minute")];
//    NSInteger limit = [alarmDic[@"limit"] integerValue];
//    detialText = [NSString stringWithFormat:@"%@,%ld%@", detialText, (long)limit, localizedString(@"times")];
    
//    cell.detailTextLabel.text = detialText;
    
    UIView *accessoryView = nil;
    if(isEdit){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.layer.cornerRadius =  13;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        accessoryView = button;
    }else{
        UISwitch *switchView = [[UISwitch alloc] init];
        switchView.backgroundColor = [UIColor clearColor];
        switchView.on = fenceEnable;
        [switchView addTarget:self action:@selector(switchChaged:) forControlEvents:UIControlEventValueChanged];
        accessoryView = switchView;
    }
    CGFloat viewWidth = 60;
    CGFloat viewHeight = 30;
    CGFloat rightGap = 10;
    accessoryView.tag = row;
    accessoryView.frame = CGRectMake((tableView.frame.size.width - rightGap - viewWidth), (celleHeight - viewHeight)/2, viewWidth, viewHeight);
    cell.accessoryView = accessoryView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)switchChaged:(UISwitch*)aSwitch{
//    NSDictionary *dic = self.viewModel.fences[aSwitch.tag];
//    NSString *fenceID = dic[@"fence_id"];
//    BOOL enable = ![dic[@"status"] boolValue];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES].dimBackground = YES;
//    self.viewModel.fenceID = fenceID;
//    [self.viewModel enableFence:enable];
}
- (void)editAction{
    isEdit = !isEdit;
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YGFenceEditVC *fenceEditVC = [[YGFenceEditVC alloc] init];
    [self presentViewController:fenceEditVC animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return celleHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeadViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}

@end
