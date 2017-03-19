//
//  YGRegisterVC.m
//  YGSchool
//
//  Created by faith on 17/2/16.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGRegisterVC.h"
#import "YGCommon.h"
@interface YGRegisterVC ()
{
    NSString *schoolId;
    NSString *classId;
    NSString *studentId;
    NSString *relation;
}
@property(nonatomic, strong) YGBoardView *registerView;
@property(nonatomic, strong) YGRegisterShadeView *registerShadeView;
@property(nonatomic, strong) UITextField *phoneTXF;
@property(nonatomic, strong) UITextField *verifyTXF;
@property(nonatomic, strong) UITextField *nameTXF;
@property(nonatomic, strong) UITextField *passwordTXF;
@property(nonatomic, strong) UITextField *repasswordTXF;
@property(nonatomic, strong) UIButton *registerBtn;
@property(nonatomic, strong) UIButton *sendVerifyCode;
@property(nonatomic, strong) UILabel *sendVerifyLabel;
@property(nonatomic, assign) BOOL phoneType; //发送验证码状态
@property(nonatomic, assign) NSInteger timeNumber;
@property(nonatomic, strong) NSMutableArray *schoolArray;
@property(nonatomic, strong) NSMutableArray *classArray;
@property(nonatomic, strong) NSMutableArray *studentArray;

@end

@implementation YGRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"注册";
    self.phoneType = NO;
    self.view.backgroundColor = COLOR_WITH_HEX(0xebeef3);
    [self addSubView];
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
- (YGBoardView *)registerView{
    if(!_registerView){
        _registerView = [[YGBoardView alloc] initWithFrame:CGRectMake(10, 90, kScreenWidth - 20, 150)];
        [_registerView setLineNumber:4];
        [_registerView setCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    }
    return _registerView;
}
- (YGRegisterShadeView *)registerShadeView{
    if(!_registerShadeView){
        _registerShadeView = [[YGRegisterShadeView alloc] initWithFrame:CGRectMake(0, 270, kScreenWidth, 120)];
    }
    return _registerShadeView;
}
- (void)addSubView{
    [self.view addSubview:self.registerView];
    [self addTXF];
    [self addBtn];
}
- (void)addTXF{
    _phoneTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 40, 30)];
    _phoneTXF.font = [UIFont systemFontOfSize:16];
    _phoneTXF.placeholder = @"请输入您手机号码";
    [self.registerView addSubview:_phoneTXF];
    _verifyTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 40, 30)];
    _verifyTXF.font = [UIFont systemFontOfSize:16];
    _verifyTXF.placeholder = @"请输入验证码";
    [self.registerView addSubview:_verifyTXF];
    _nameTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, kScreenWidth - 40, 30)];
    _nameTXF.font = [UIFont systemFontOfSize:16];
    _nameTXF.placeholder = @"请输入您的姓名";
    [self.registerView addSubview:_nameTXF];
    _passwordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 91, kScreenWidth - 40, 30)];
    _passwordTXF.font = [UIFont systemFontOfSize:16];
    _passwordTXF.secureTextEntry = YES;
    _passwordTXF.placeholder = @"请输入密码";
    [self.registerView addSubview:_passwordTXF];
    _repasswordTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 121, kScreenWidth - 40, 30)];
    _repasswordTXF.secureTextEntry = YES;
    _repasswordTXF.font = [UIFont systemFontOfSize:16];
    _repasswordTXF.placeholder = @"请再次输入密码";
    [self.registerView addSubview:_repasswordTXF];
    
    [self.view addSubview:self.registerShadeView];
    __block YGRegisterVC *weakVC = self;
    self.registerShadeView.chooseSchBlock = ^{
        [weakVC getSchoolList];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"请选择您的孩子所在的学校",@"温州小学",@"温州小学2",@"塘下镇罗凤四小"];
//        [weakVC.schoolArray insertObject:@"请选择您的孩子所在的学校" atIndex:0];
//        shadeView.titleArray = weakVC.schoolArray;
        shadeView.chooseBlock = ^(NSString *title){
            weakVC.registerShadeView.chooseSchTXF.text = title;
            // 获取所有的学校可以在控制器中，也可以在view中
            [weakShadeView dissmiss];
            [weakVC.registerShadeView showChooseClass];
        };
        [weakVC.view.window addSubview:shadeView];

    };
    self.registerShadeView.chooseClassBlock = ^{
        [self getClassList];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"请选择您要关联的学生所在的班级",@"小学一年级(01)班",@"小学一年级(02)班",@"小学二年级(01)班",@"小学二年级(02)班",@"小学三年级(01)班",@"小学三年级(02)班",@"小学四年级(01)班",@"小学四年级(02)班",@"小学五年级(01)班",@"小学五年级(02)班",@"小学六年级(01)班",@"小学六年级(02)班"];
//        [weakVC.classArray insertObject:@"请选择您要关联的学生所在的班级" atIndex:0];
//        shadeView.titleArray = weakVC.classArray;
        
        shadeView.chooseBlock = ^(NSString *title){
            weakVC.registerShadeView.chooseClassTXF.text = title;
            [weakShadeView dissmiss];
            [weakVC.registerShadeView showChooseStudent];
        };
        [weakVC.view.window addSubview:shadeView];
    };
    self.registerShadeView.chooseStudentBlock = ^{
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"请选择您要关联的学生",@"袁于海",@"金亮",@"吴海能"];
        
//        [weakVC.studentArray insertObject:@"请选择您要关联的学生" atIndex:0];
//        shadeView.titleArray = weakVC.studentArray;
        shadeView.chooseBlock = ^(NSString *title){
            weakVC.registerShadeView.chooseStudentTXF.text = title;
            [weakShadeView dissmiss];
            //            [weakbindShadeView showChooseStudent];
        };
        [weakVC.view.window addSubview:shadeView];
    };
}
- (void)addBtn{
    self.registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 410, kScreenWidth - 50, 35)];
    self.registerBtn.layer.cornerRadius = 7;
    [self.registerBtn.layer setMasksToBounds:YES];
    [self.registerBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 125, 0, 1, 30)];
    lineView.backgroundColor = COLOR(221, 221, 221, 1);
    [_verifyTXF addSubview:lineView];
    _sendVerifyCode = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 120, 5, 80, 20)];
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
- (void)registerAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    if (!self.phoneType) {
        alertMessage = @"请发送验证码";
    }else{
        if([_verifyTXF.text length] == 0){
            alertMessage = @"请输入验证码";
        }else if([_nameTXF.text length] ==0){
            alertMessage = @"请输入您的姓名";
        }else if ([_passwordTXF.text length]==0 || [_repasswordTXF.text length] ==0){
            alertMessage = @"请输入密码";
        }else if (![_passwordTXF.text isEqualToString:_repasswordTXF.text]){
            alertMessage = @"两次密码不相同";
        }else if ([self.registerShadeView.chooseSchTXF.text length] ==0 || schoolId == nil){
            alertMessage = @"请选择您的孩子所在的学校";
        }else if ([self.registerShadeView.chooseClassTXF.text length] ==0 || classId == nil){
            alertMessage = @"请选择您要关联的学生所在的班级";
        }else if ([self.registerShadeView.chooseStudentTXF.text length] ==0 || studentId == nil){
            alertMessage = @"请填写您要关联的学生";
        }else if ([self.registerShadeView.relationTXF.text length] ==0 || relation == nil){
            alertMessage = @"请填写您和学生的关系";
        }else{
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            NSString *password = [_passwordTXF.text stringToMD5:_passwordTXF.text];
            [parameter setObject:@"register" forKey:@"event_code"];
            [parameter setObject:_phoneTXF.text forKey:@"phone"];
            [parameter setObject:_phoneTXF.text forKey:@"user_name"];
            [parameter setObject:_verifyTXF.text forKey:@"sms_code"];
            [parameter setObject:_nameTXF.text forKey:@"name"];
            [parameter setObject:password forKey:@"password"];
            [parameter setObject:schoolId forKey:@"school_id"];
            [parameter setObject:classId forKey:@"class_id"];
            [parameter setObject:studentId forKey:@"student_id"];
            [parameter setObject:self.registerShadeView.relationTXF.text forKey:@"relation"];
            [YGNetWorkManager registerWithParameter:parameter completion:^(id responseObject) {
                
            } fail:^{
            }];
            return;
        }

    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)sendVerifyCodeAction{
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
- (void)getSchoolList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"schoolList" forKey:@"event_code"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    NSLog(@"parameter:%@",parameter);
    [YGNetWorkManager getSchoolListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        _schoolArray = responseObject[@"list"];
    } fail:^{
        NSLog(@"");
    }];
}
- (void)getClassList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"classList" forKey:@"event_code"];
    [dic setObject:@"1001" forKey:@"school_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager getClassListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
- (void)getStudentList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"studentList" forKey:@"event_code"];
    [dic setObject:@"studentList" forKey:@"account_id"];
    [dic setObject:@"studentList" forKey:@"class_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [YGNetWorkManager getStudentListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
@end
