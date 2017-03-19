//
//  YGScoreVC.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGScoreVC.h"
#import "YGCommon.h"
@interface YGScoreVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *scoreArray;
@end

@implementation YGScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成绩";
    self.rightBtn.hidden = YES;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headView.backgroundColor = COLOR_WITH_HEX(0x8acee9);
    [self.view addSubview:headView];
    NSArray *array = @[@"学生名字",@"课程名称",@"考试类型",@"课程成绩"];
    CGFloat w = kScreenWidth/4;
    for(int i = 0; i < 4; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*w, 0, w, 40)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        [headView addSubview:label];
    }
    [self.view addSubview:self.tableView];
    [self queryScore];
}
- (NSArray *)scoreArray{
    if(!_scoreArray){
        _scoreArray = [[NSArray alloc] init];
    }
    return _scoreArray;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self endRefresh];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    
        }];
    }
    return _tableView;
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.scoreArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YGScoreListCell";
    YGScoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[YGScoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if(self.scoreArray.count>0){
        NSDictionary *dic = self.scoreArray[indexPath.row];
        cell.nameLbl.text = dic[@"name"];
        cell.courseLbl.text = dic[@"course "];
        cell.typeLbl.text = dic[@"type"];
        cell.scoreLbl.text = dic[@"score"];
    }
    return cell;
}
- (void)queryScore{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"recordSearch" forKey:@"event_code"];
    [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
    [dic setObject:@"1001" forKey:@"class_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager queryScoreWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        if([responseObject[@"code"] integerValue] ==1){
            self.scoreArray = responseObject[@"dt"];
            [self.tableView reloadData];
        }
    } fail:^{
        
    }];
}
@end
