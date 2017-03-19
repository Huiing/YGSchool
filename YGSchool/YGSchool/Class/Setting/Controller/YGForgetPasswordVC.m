//
//  YGForgetPasswordVC.m
//  YGSchool
//
//  Created by faith on 17/2/16.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGForgetPasswordVC.h"
#import "YGCommon.h"
@interface YGForgetPasswordVC ()
@property(nonatomic, strong)YGBoardView *findPasswordView;
@property(nonatomic, strong) UITextField *phoneTXF;
@property(nonatomic, strong) UITextField *verifyTXF;
@property(nonatomic, strong) UITextField *newpasswordTXF;
@property(nonatomic, strong) UITextField *renewpasswordTXF;
@property(nonatomic, strong) UIButton *confirmBtn;
@property(nonatomic, strong) UIButton *sendVerifyCode;
@property(nonatomic, strong) UILabel *sendVerifyLabel;
@property(nonatomic, assign) BOOL phoneType; //发送验证码状态
@property(nonatomic, assign) NSInteger timeNumber;
@property(nonatomic, assign) BOOL isCorrectCode;
@end

@implementation YGForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"找回密码";
    self.rightBtn.hidden = YES;
    self.view.backgroundColor = COLOR_WITH_HEX(0xebeef3);
    [self addSubView];
}
- (void)addSubView{
    [self.view addSubview:self.findPasswordView];
    [self addTXF];
    [self addBtn];
}
- (YGBoardView *)findPasswordView{
    if(!_findPasswordView){
        _findPasswordView = [[YGBoardView alloc] initWithFrame:CGRectMake(20, 80, kScreenWidth - 40, 120)];
        [_findPasswordView setLineNumber:3];
        [_findPasswordView setCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    }
    return _findPasswordView;
}
- (void)addTXF{
    _phoneTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 40, 30)];
    _phoneTXF.font = [UIFont systemFontOfSize:16];
    _phoneTXF.placeholder = @"请输入您手机号码";
    [self.findPasswordView addSubview:_phoneTXF];
    _verifyTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 40, 30)];
    _verifyTXF.font = [UIFont systemFontOfSize:16];
    _verifyTXF.placeholder = @"请输入验证码";
    [self.findPasswordView addSubview:_verifyTXF];
    _newpasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, kScreenWidth - 40, 30)];
    _newpasswordTXF.secureTextEntry = YES;
    _newpasswordTXF.font = [UIFont systemFontOfSize:16];
    _newpasswordTXF.placeholder = @"请输入密码";
    [self.findPasswordView addSubview:_newpasswordTXF];
    _renewpasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 91, kScreenWidth - 40, 30)];
    _renewpasswordTXF.secureTextEntry = YES;
    _renewpasswordTXF.font = [UIFont systemFontOfSize:16];
    _renewpasswordTXF.placeholder = @"请再次输入密码";
    [self.findPasswordView addSubview:_renewpasswordTXF];
    
    
}
- (void)addBtn{
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 230, kScreenWidth - 50, 35)];
    self.confirmBtn.layer.cornerRadius = 7;
    [self.confirmBtn.layer setMasksToBounds:YES];
    [self.confirmBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 139, 0, 1, 30)];
    lineView.backgroundColor = COLOR(221, 221, 221, 1);
    [_verifyTXF addSubview:lineView];
    _sendVerifyCode = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 135, 5, 80, 20)];
    _sendVerifyCode.layer.cornerRadius = 7;
    _sendVerifyCode.layer.borderColor = [UIColor grayColor].CGColor;
    _sendVerifyCode.layer.borderWidth = 1.0;
    [_sendVerifyCode.layer setMasksToBounds:YES];
    _sendVerifyCode.titleLabel.font = [UIFont systemFontOfSize:12];
    [_sendVerifyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendVerifyCode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_sendVerifyCode addTarget:self action:@selector(sendVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_verifyTXF addSubview:_sendVerifyCode];
    _sendVerifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    _sendVerifyLabel.font = [UIFont systemFontOfSize:12];
    _sendVerifyLabel.textAlignment = NSTextAlignmentCenter;
    [_sendVerifyCode addSubview:_sendVerifyLabel];
}
- (void)sendVerifyCodeAction{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"passwordForget1" forKey:@"event_code"];
    [parameter setObject:@"passwordForget1" forKey:@"account_id"];
    [parameter setObject:@"passwordForget1" forKey:@"user_name"];
    NSMutableDictionary *parameter2 = [[NSMutableDictionary alloc] init];
    [parameter2 setObject:@"passwordForget2" forKey:@"event_code"];
    [parameter2 setObject:@"passwordForget1" forKey:@"account_id"];
    [parameter2 setObject:@"passwordForget1" forKey:@"user_name"];
    [parameter2 setObject:@"passwordForget1" forKey:@"code_code"];
    if([_phoneTXF.text isPhoneNumber]){
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTXF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if(!error){
                NSLog(@"获取验证码成功");
                [MBProgressHUD showSuccess:@"发送验证码成功"];
                self.phoneType = YES;
                _phoneTXF.userInteractionEnabled = NO;
                _phoneTXF.textColor = [UIColor grayColor];
                self.timeNumber = 6;
                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
                [timer fire];
                
            }else{
                NSLog(@"错误信息：%@",error);
                self.phoneType = NO;
            }
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }

    
    if([_phoneTXF.text isPhoneNumber]){
        [YGNetWorkManager sendVerifyCodeWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if([responseObject[@"code"] integerValue] ==1){
                [YGNetWorkManager verifyWithParameter:parameter2 completion:^(id responseObject) {
                    self.phoneType = YES;
                    _phoneTXF.userInteractionEnabled = NO;
                    _phoneTXF.textColor = [UIColor grayColor];
                    self.timeNumber = 6;
                    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
                    [timer fire];
                    
                    NSLog(@"responseObject:%@",responseObject);
                    if([responseObject[@"code"] integerValue] ==1){
                        self.isCorrectCode = YES;
                    }else{
                        self.isCorrectCode = NO;
                    }
                } fail:^{
                    
                }];
            }
        } fail:^{
            
        }];

    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)time:(NSTimer *)timer{
    self.sendVerifyCode.userInteractionEnabled = NO;
    self.sendVerifyLabel.text = [NSString stringWithFormat:@"%ldS再发送",self.timeNumber];
    self.sendVerifyCode.backgroundColor = [UIColor grayColor];
    _phoneTXF.userInteractionEnabled = NO;
    _phoneTXF.textColor = [UIColor grayColor];
    self.timeNumber--;
    if (self.timeNumber < 0) {
        [timer invalidate];
        timer = nil;
        self.sendVerifyCode.userInteractionEnabled =YES;
        self.sendVerifyLabel.text = @"发送验证码";
        //        self.FaSongBtn.backgroundColor = DefaultColor;
        _phoneTXF.userInteractionEnabled = YES;
        _phoneTXF.textColor = [UIColor blackColor];
    }
}
- (void)confirmAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    if (!self.phoneType) {
        alertMessage = @"请发送验证码";
    }else{
        if([_verifyTXF.text length] == 0){
            alertMessage = @"请输入验证码";
        }else if([_newpasswordTXF.text length] ==0){
            alertMessage = @"请输入密码";
        }else if ([_renewpasswordTXF.text length]==0){
            alertMessage = @"请再次输入密码";
        }else if (![_newpasswordTXF.text isEqualToString:_renewpasswordTXF.text]){
            alertMessage = @"两次密码不相同";
        }else if(!self.isCorrectCode){
            alertMessage = @"验证码错误";
        }else{
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:@"passwordForget3" forKey:@"event_code"];
            [parameter setObject:@"passwordForget1" forKey:@"account_id"];
            [parameter setObject:@"passwordForget1" forKey:@"user_name"];
            [parameter setObject:@"passwordForget1" forKey:@"new_password"];
            [YGNetWorkManager registerWithParameter:parameter completion:^(id responseObject) {
                NSLog(@"responseObject:%@",responseObject);
                
            } fail:^{
                
            }];
        }
    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    NSString *password = [_passwordTXF.text stringToMD5:_passwordTXF.text];
//    [parameter setObject:@"register" forKey:@"event_code"];
//    [parameter setObject:_phoneTXF.text forKey:@"phone"];
//    [parameter setObject:_phoneTXF.text forKey:@"user_name"];
//    [parameter setObject:_verifyTXF.text forKey:@"sms_code"];
//    [parameter setObject:_nameTXF.text forKey:@"name"];
//    [parameter setObject:password forKey:@"password"];
//    [parameter setObject:schoolId forKey:@"school_id"];
//    [parameter setObject:classId forKey:@"class_id"];
//    [parameter setObject:studentId forKey:@"student_id"];
//    [parameter setObject:self.registerShadeView.relationTXF.text forKey:@"relation"];
    [YGNetWorkManager registerWithParameter:parameter completion:^(id responseObject) {
        
    } fail:^{
    }];

}
@end
