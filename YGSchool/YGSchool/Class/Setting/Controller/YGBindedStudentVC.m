//
//  YGBindedStudentVC.m
//  YGSchool
//
//  Created by faith on 17/2/23.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBindedStudentVC.h"
#import "YGCommon.h"
@interface YGBindedStudentVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *selectSchoolID;
    NSString *selectClassID;
    NSString *selectStudentID;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *schoolArray;
@property(nonatomic, strong) NSMutableArray *classArray;
@property(nonatomic, strong) NSMutableArray *studentArray;
@property(nonatomic, strong) YGShadeView *shadeView1;
@property(nonatomic, strong) YGShadeView *shadeView2;
@property(nonatomic, strong) YGShadeView *shadeView3;

@end

@implementation YGBindedStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已绑定的学生";
    _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableView];
    [YGShow fullSperatorLine:self.tableView];
}
- (NSMutableArray *)schoolArray{
    if(!_schoolArray){
        _schoolArray = [[NSMutableArray alloc] init];
    }
    return _schoolArray;
}
- (NSMutableArray *)classArray{
    if(!_classArray){
        _classArray = [[NSMutableArray alloc] init];
    }
    return _classArray;
}
- (NSMutableArray *)studentArray{
    if(!_studentArray){
        _studentArray = [[NSMutableArray alloc] init];
    }
    return _studentArray;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YGBindedStudentCell";
    YGBindedStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[YGBindedStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"解绑";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
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
    YGAddBindShadeView *bindShadeView = [[YGAddBindShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    __block YGAddBindShadeView *weakbindShadeView  = bindShadeView;
    bindShadeView.chooseSchBlock = ^{
        [self getSchoolList];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        _shadeView1 = shadeView;
        __block YGShadeView *weakShadeView  = shadeView;
//        shadeView.titleArray = @[@"请选择您的孩子所在的学校",@"温州小学",@"温州小学2",@"塘下镇罗凤四小"];
        shadeView.chooseBlock = ^(NSString *title){
            for(NSDictionary *dic in self.schoolArray){
                if([title isEqualToString:dic[@"name"]]){
                    selectSchoolID = dic[@"school_id"];
                    break;
                }
            }
            weakbindShadeView.chooseSchTXF.text = title;
            [weakShadeView dissmiss];
            [weakbindShadeView showChooseClass];
        };
        [self.view.window addSubview:shadeView];
    };
    bindShadeView.chooseClassBlock = ^{
        [self getClassList];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        _shadeView2 = shadeView;

        __block YGShadeView *weakShadeView  = shadeView;
//        shadeView.titleArray = @[@"请选择您要关联的学生所在的班级",@"小学一年级(01)班",@"小学一年级(02)班",@"小学二年级(01)班",@"小学二年级(02)班",@"小学三年级(01)班",@"小学三年级(02)班",@"小学四年级(01)班",@"小学四年级(02)班",@"小学五年级(01)班",@"小学五年级(02)班",@"小学六年级(01)班",@"小学六年级(02)班"];
        shadeView.chooseBlock = ^(NSString *title){
            for(NSDictionary *dic in self.classArray){
                if([title isEqualToString:dic[@"name"]]){
                    selectClassID = dic[@"class_id"];
                    break;
                }
            }

            weakbindShadeView.chooseClassTXF.text = title;
            [weakShadeView dissmiss];
            [weakbindShadeView showChooseStudent];
        };
        [self.view.window addSubview:shadeView];
    };
    bindShadeView.chooseStudentBlock = ^{
        [self getStudentList];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        _shadeView3 = shadeView;
        __block YGShadeView *weakShadeView  = shadeView;
//        shadeView.titleArray = @[@"请选择您要关联的学生",@"袁于海",@"金亮",@"吴海能"];
        shadeView.chooseBlock = ^(NSString *title){
            for(NSDictionary *dic in self.studentArray){
                if([title isEqualToString:dic[@"name"]]){
                    selectStudentID = dic[@"student_id"];
                    break;
                }
            }

            weakbindShadeView.chooseStudentTXF.text = title;
            [weakShadeView dissmiss];
//            [weakbindShadeView showChooseStudent];
        };
        [self.view.window addSubview:shadeView];
    };
    [bindShadeView.confirmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bindShadeView.cancleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:bindShadeView];
}
- (void)addStudent{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"studentAdd" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [YGNetWorkManager addStudentWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
- (void)unBindStudent{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"studentDel" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"student_id"];
    [YGNetWorkManager unBindStudentWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"");
    } fail:^{
        
    }];
}
- (void)addStudentVerify{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"studentAddAdult" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"add_id"];
    [parameter setObject:@"" forKey:@"status"];
    [YGNetWorkManager addStudentVerifyWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
- (void)getSchoolList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"schoolList" forKey:@"event_code"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    NSLog(@"parameter:%@",parameter);
    [YGNetWorkManager getSchoolListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        self.schoolArray = responseObject[@"list"];
        NSMutableArray *a = [[NSMutableArray alloc] initWithObjects:@"请选择您的孩子所在的学校", nil];
        for(int i = 0; i < self.schoolArray.count; i++){
            NSDictionary *dic = self.schoolArray[i];
            [a addObject:dic[@"name"]];
        }
        _shadeView1.titleArray = a;
    } fail:^{
        NSLog(@"");
    }];
}
- (void)getClassList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"classList" forKey:@"event_code"];
    [dic setObject:selectSchoolID forKey:@"school_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager getClassListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        self.classArray = responseObject[@"list"];
        NSMutableArray *a = [[NSMutableArray alloc] initWithObjects:@"请选择您要关联的学生所在的班级", nil];
        for(int i = 0; i < self.classArray.count; i++){
            NSDictionary *dic = self.classArray[i];
            [a addObject:dic[@"name"]];
        }
        _shadeView2.titleArray = a;

    } fail:^{
        
    }];
}
- (void)getStudentList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"studentList" forKey:@"event_code"];
    [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
    [dic setObject:selectClassID forKey:@"class_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager getStudentListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        self.studentArray = responseObject[@"list"];
        NSMutableArray *a = [[NSMutableArray alloc] initWithObjects:@"请选择您要关联的学生", nil];
        for(int i = 0; i < self.studentArray.count; i++){
            NSDictionary *dic = self.studentArray[i];
            [a addObject:dic[@"name"]];
        }
        _shadeView3.titleArray = a;

    } fail:^{
        
    }];
}
- (void)btnAction:(UIButton *)button{
    NSInteger tag = button.tag;
    if(tag ==0){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"studentAdd" forKey:@"event_code"];
        [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
        [dic setObject:selectSchoolID forKey:@"school_id"];
        [dic setObject:selectSchoolID forKey:@"class_id"];
        [dic setObject:selectStudentID forKey:@"student_id"];
        [dic setObject:@"父子" forKey:@"relation"];
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        NSString *str = [YGTools convertToJsonString:dic];
        [parameter setObject:str forKey:@"content"];
        [YGNetWorkManager addStudentWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        } fail:^{
            
        }];
    }else{
        
    }
}
@end
