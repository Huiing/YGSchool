//
//  YGRemindRecevieVC.m
//  YGSchool
//
//  Created by faith on 17/3/9.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGRemindRecevieVC.h"
#import "YGCommon.h"
const static CGFloat cellHeight = 40;
const static CGFloat cellHeadHeight = 35;

@interface YGRemindRecevieVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSArray                   *tableList;
@property (nonatomic, assign) NSInteger                 receiveInterval;
@property (nonatomic, assign) NSInteger                 receiveTimes;
@end

@implementation YGRemindRecevieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"接收提醒";
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.tableView];
}
#pragma mark - getters and setters
- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight-54) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray*)tableList{
    if(_tableList == nil){
        _tableList = @[@{@"head":@"提醒频率", @"title":@[@"5分钟", @"10分钟", @"15分钟", @"30分钟"]},
                       @{@"head":@"通知次数", @"title":@[@"1次", @"2次", @"3次"]}];
    }
    return _tableList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.tableList[section];
    NSArray *titles = dic[@"title"];
    return titles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.tableList[section];
    NSString *head = dic[@"head"];
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"fenceEditCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    NSDictionary *dic = self.tableList[section];
    NSArray *titles = dic[@"title"];
    cell.textLabel.text = titles[row];
    
    BOOL needTick = NO;
    switch (section) {
        case 0:{
            needTick = (row == self.receiveInterval);
        }
            break;
            
        case 1:{
            needTick = (row == self.receiveTimes);
        }
            break;
            
    }
    
    if(needTick){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"tickIocn"];
        CGFloat viewWidth = 20;
        CGFloat viewHeight = 20;
        CGFloat rightGap = 10;
        imageView.frame = CGRectMake((tableView.frame.size.width - rightGap - viewWidth), (cellHeight - viewHeight)/2, viewWidth, viewHeight);
        cell.accessoryView = imageView;
    }else{
        cell.accessoryView = nil;
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeadHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:{
            self.receiveInterval = row;
        }
            break;
            
        case 1:{
            self.receiveTimes = row;
        }
            break;
            
    }
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


@end
