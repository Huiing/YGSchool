//
//  YGLoginVC.m
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGLoginVC.h"
#import "YGCommon.h"
@interface YGLoginVC ()<UITextFieldDelegate>
@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) YGBoardView *loginView;
@property(nonatomic, strong) UITextField *userTypeTXF;
@property(nonatomic, strong) UITextField *phoneTXF;
@property(nonatomic, strong) UITextField *passwordTXF;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIButton *wechatLogin;
@property(nonatomic, strong) UIButton *registerBtn;
@property(nonatomic, strong) UIButton *forgetBtn;
@end

@implementation YGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    bgImgView.image = [UIImage imageNamed:@"login_bg"];
    [myView addSubview:bgImgView];
    [myView sendSubviewToBack:bgImgView];
    [self.view addSubview:myView];
    [self addSubViews];

}
- (UIImageView *)logoImageView{
    if(!_logoImageView){
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 120)/2, 20, 120, 120)];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.layer.cornerRadius = 10;
        [_logoImageView.layer setMasksToBounds:YES];
        _logoImageView.backgroundColor = [UIColor whiteColor];
    }
    return _logoImageView;
}
- (YGBoardView *)loginView{
    if(!_loginView){
        _loginView = [[YGBoardView alloc] initWithFrame:CGRectMake(25, 150, kScreenWidth - 50, 90)];
        [_loginView setLineNumber:2];
        [_loginView setCorner:UIRectCornerAllCorners];
    }
    return _loginView;
}
- (void)addTXF{
    _userTypeTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 100, 30)];
    _userTypeTXF.delegate = self;
    _userTypeTXF.font = [UIFont systemFontOfSize:16];
    _userTypeTXF.placeholder = @"请选择用户类型";
    [self.loginView addSubview:_userTypeTXF];
    _phoneTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 100, 30)];
    _phoneTXF.font = [UIFont systemFontOfSize:16];
    _phoneTXF.placeholder = @"请输入手机号码";
    _phoneTXF.text = kAccount;
    [self.loginView addSubview:_phoneTXF];
    _passwordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, kScreenWidth - 100, 30)];
    _passwordTXF.secureTextEntry = YES;
    _passwordTXF.font = [UIFont systemFontOfSize:16];
    _passwordTXF.placeholder = @"请输入登录密码";
    _passwordTXF.text = kPassword;
    [self.loginView addSubview:_passwordTXF];
}
- (void)addBtn{
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 260, kScreenWidth - 50, 35)];
    self.loginBtn.layer.cornerRadius = 7;
    [self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 305, kScreenWidth - 50, 35)];
    self.backBtn.layer.cornerRadius = 7;
    [self.backBtn.layer setMasksToBounds:YES];
    [self.backBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.backBtn];
    
    _wechatLogin = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 60)/2, 360, 60, 60)];
    [_wechatLogin setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [self.view addSubview:_wechatLogin];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 440, 120, 20)];
    [_registerBtn setTitle:@"家长注册新账号" forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 120, 440, 80, 20)];
    [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_forgetBtn addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetBtn];
}
- (void)addSubViews{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginView];
    [self addTXF];
    [self addBtn];
}
- (void)loginAction{
//    NSString *p = [[YGLDataManager shareInstance] userCacheFilePath];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:p];
//    if(!dic) dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"login"];
//    [dic setObject:@"您好，" forKey:@"username"];
//    [dic writeToFile:p atomically:YES];
//    [[YGLDataManager shareInstance] getUserData];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    _phoneTXF.text = @"13632948837";
    if([_userTypeTXF.text length] ==0){
        alertMessage = @"请选择用户类型";
    }else if ([_phoneTXF.text length] ==0){
        alertMessage = @"请输入手机号码";
    }else if(![_phoneTXF.text isPhoneNumber]){
        alertMessage = @"手机号码格式不正确";
    }else if ([_passwordTXF.text length] ==0){
        alertMessage = @"请输入登录密码";
    }else{
        NSString *userTpye;
        if([_userTypeTXF.text isEqualToString:@"家长"]){
            userTpye = [[NSNumber numberWithInt:1] stringValue];
        }else{
            userTpye = [[NSNumber numberWithInt:2] stringValue];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *password = _passwordTXF.text;
//        NSString *password = [_passwordTXF.text stringToMD5:_passwordTXF.text];
        [dic setObject:@"login" forKey:@"event_code"];
        [dic setObject:_phoneTXF.text forKey:@"user_name"];
        [dic setObject:password forKey:@"password"];
        [dic setObject:userTpye forKey:@"user_type"];
        
        NetStatusType netStatus = [YGLDataManager manager].netStatusType;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSString *pushId = [YGLDataManager manager].userData.pushId;
        if(!pushId) pushId = @"";
        NSMutableDictionary *appDic = [NSMutableDictionary dictionary];
        [appDic setObject:@"" forKey:@"app_build"];
        [appDic setObject:@"" forKey:@"net_type"];
        [appDic setObject:currentLanguage forKey:@"lang"];
        [appDic setObject:pushId forKey:@"push_id"];
        [dic setObject:appDic forKey:@"app"];
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        NSString *str = [YGTools convertToJsonString:dic];
        [parameter setObject:str forKey:@"content"];
        NSLog(@"parameter:%@",parameter);
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        [YGNetWorkManager loginWithParameter:parameter completion:^(id responseObject) {
            if([responseObject[@"code"] integerValue] ==1){
                NSDictionary *accountDic = responseObject[@"account"];
                
                YGUserData *userData = [YGLDataManager manager].userData;
                userData.name = accountDic[@"name"];
                userData.userName = accountDic[@"user_name"];
                userData.accountID = accountDic[@"account_id"];
                userData.schoolID = accountDic[@"school_id"];
                userData.phone = accountDic[@"phone"];
                userData.headIcon = accountDic[@"head_icon"];
                userData.userType = @"1";
                NSString *path = [[YGLDataManager manager] userCacheFilePath];
                NSMutableDictionary *account = [[NSMutableDictionary alloc] initWithDictionary:accountDic];
                [account setObject:[NSNumber numberWithBool:YES] forKey:@"login"];
                [account writeToFile:path atomically:YES];

                userData.login = YES;
                [YGShow showRootViewController];
            }
            NSLog(@"responseObject:%@",responseObject);
        } fail:^{
            
        }];
        return;

    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];
    
//    NSNumber *userTpye;
//    if([_userTypeTXF.text isEqualToString:@"家长"]){
//        userTpye = [NSNumber numberWithInt:1];
//    }else{
//        userTpye = [NSNumber numberWithInt:2];
//    }
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    NSString *password = [_passwordTXF.text stringToMD5:_passwordTXF.text];
//    [parameter setObject:@"login" forKey:@"event_code"];
//    [parameter setObject:_phoneTXF.text forKey:@"phone"];
//    [parameter setObject:password forKey:@"password"];
//    [parameter setObject:userTpye forKey:@"user_type"];
//    
//    NetStatusType netStatus = [YGLDataManager shareInstance].netStatusType;
//    NSString *netStatusTypeString = [NSString stringWithFormat:@"%ld",(long)netStatus];
//    NSArray *languages = [NSLocale preferredLanguages];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//    NSString *pushId = [YGLDataManager shareInstance].userData.pushId;
//    if(!pushId) pushId = @"";
//    NSMutableDictionary *appDic = [NSMutableDictionary dictionary];
//    [appDic setObject:@"" forKey:@"app_build"];
//    [appDic setObject:netStatusTypeString forKey:@"net_type"];
//    [appDic setObject:@"" forKey:@"user_type"];
//    [appDic setObject:currentLanguage forKey:@"lang"];
//    [appDic setObject:pushId forKey:@"push_id"];
//    [parameter setObject:appDic forKey:@"app"];
//    
//    [YGNetWorkManager loginWithParameter:parameter completion:^(id responseObject) {
//        
//    } fail:^{
//        
//    }];


}
- (void)backAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)registerAction:(UIButton *)sender{
//    UIView *backgroundView = [[UIView alloc] init];
//    backgroundView.frame = CGRectMake(0, 568,320,568);
//    backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
//    backgroundView.alpha = 0.6;
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(25, 100, kScreenWidth-50, 200)];
//    view1.backgroundColor = [UIColor whiteColor];
//    [backgroundView addSubview:view1];
//    [self.view.window addSubview:backgroundView];
//    [UIView animateWithDuration:0.5 animations:^{
//        backgroundView.top = 0;
//    }];
    YGRegisterVC *registerVC = [[YGRegisterVC alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (void)forgetPasswordAction:(UIButton *)sender{
    YGForgetPasswordVC *forgetPasswordVC = [[YGForgetPasswordVC alloc] init];
    [self presentViewController:forgetPasswordVC animated:YES completion:nil];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([textField isEqual:_userTypeTXF]){
        [textField resignFirstResponder];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"请选择用户类型",@"家长",@"教师"];
        shadeView.chooseBlock = ^(NSString *title){
            _userTypeTXF.text = title;
            [weakShadeView dissmiss];
        };
        [self.view.window addSubview:shadeView];
    }
}
@end
