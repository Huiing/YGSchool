//
//  YGEditInformationVC.m
//  YGSchool
//
//  Created by faith on 17/2/16.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGEditInformationVC.h"
#import "YGCommon.h"
@interface YGEditInformationVC ()
@property(nonatomic, strong)UITextField *nameTXF;
@property(nonatomic, strong)YGBoardView *changePasswordView;
@property(nonatomic, strong) UITextField *oldpasswordTXF;
@property(nonatomic, strong) UITextField *newpasswordTXF;
@property(nonatomic, strong) UITextField *renewpasswordTXF;
@property(nonatomic, strong) UIButton *confirmBtn;
@end

@implementation YGEditInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"编辑资料";
    self.view.backgroundColor = COLOR_WITH_HEX(0xebeef3);
    [self addSubView];
}
- (void)addSubView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 100, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"修改个人信息";
    [self.view addSubview:label];
    _nameTXF = [[UITextField alloc] initWithFrame:CGRectMake(15, 110, kScreenWidth-30, 30)];
    _nameTXF.borderStyle = UITextBorderStyleRoundedRect;
    _nameTXF.text = @"周林";
    [self.view addSubview:_nameTXF];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 100, 20)];
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"修改密码";
    [self.view addSubview:label2];
    [self.view addSubview:self.changePasswordView];
    [self addTXF];
    [self addBtn];

}
- (YGBoardView *)changePasswordView{
    if(!_changePasswordView){
        _changePasswordView = [[YGBoardView alloc] initWithFrame:CGRectMake(15, 190, kScreenWidth - 30, 90)];
        [_changePasswordView setLineNumber:2];
        [_changePasswordView setCorner:UIRectCornerAllCorners];
    }
    return _changePasswordView;
}
- (void)addTXF{
    _oldpasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 40, 30)];
    _oldpasswordTXF.secureTextEntry = YES;
    _oldpasswordTXF.font = [UIFont systemFontOfSize:16];
    _oldpasswordTXF.placeholder = @"请输入原密码";
    [self.changePasswordView addSubview:_oldpasswordTXF];
    _newpasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 40, 30)];
    _newpasswordTXF.secureTextEntry = YES;
    _newpasswordTXF.font = [UIFont systemFontOfSize:16];
    _newpasswordTXF.placeholder = @"请输入新密码";
    [self.changePasswordView addSubview:_newpasswordTXF];
    _renewpasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, kScreenWidth - 40, 30)];
    _renewpasswordTXF.secureTextEntry = YES;
    _renewpasswordTXF.font = [UIFont systemFontOfSize:16];
    _renewpasswordTXF.placeholder = @"请再次确认新密码";
    [self.changePasswordView addSubview:_renewpasswordTXF];
}
- (void)addBtn{
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 320, kScreenWidth - 50, 35)];
    self.confirmBtn.layer.cornerRadius = 7;
    [self.confirmBtn.layer setMasksToBounds:YES];
    [self.confirmBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
}
- (void)confirmAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    if ([_oldpasswordTXF.text length] ==0) {
        alertMessage = @"请输入原始密码";
    }else if ([_newpasswordTXF.text length] ==0){
        alertMessage = @"请输入新密码";
    }else if([_renewpasswordTXF.text length] ==0){
        alertMessage = @"请再次输入新密码";
    }else if([_newpasswordTXF.text isEqualToString:_renewpasswordTXF.text]){
        alertMessage = @"两次新密码不一致";
    }else{
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:@"passwordReset" forKey:@"event_code"];
        [parameter setObject:@"photoAdd" forKey:@"account_id"];
        [parameter setObject:@"photoAdd" forKey:@"password"];
        [parameter setObject:@"photoAdd" forKey:@"new_password"];
        [YGNetWorkManager changPassWordWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        } fail:^{
            
        }];
        return;
    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];
}
@end
