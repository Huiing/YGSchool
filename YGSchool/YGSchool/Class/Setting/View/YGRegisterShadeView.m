//
//  YGRegisterShadeView.m
//  YGSchool
//
//  Created by faith on 17/3/2.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGRegisterShadeView.h"
#import "YGCommon.h"
@interface YGRegisterShadeView()<UITextFieldDelegate>
{
    UIView *lineView1;
    UIView *lineView2;
    UIView *lineView3;

}
@end
@implementation YGRegisterShadeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews{
    self.chooseSchTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0,kScreenWidth-20 , 30)];
    self.chooseSchTXF.backgroundColor = [UIColor whiteColor];
    self.chooseSchTXF.delegate = self;
    self.chooseSchTXF.placeholder = @"请选择您的孩子所在的学校";
    [self addSubview:self.chooseSchTXF];
    lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 29, kScreenWidth-20, 1)];
    lineView1.backgroundColor = COLOR(221, 221, 221, 1);
    [self addSubview:lineView1];
    
    self.chooseClassTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 30,kScreenWidth-20 , 30)];
    self.chooseClassTXF.delegate = self;
    self.chooseClassTXF.backgroundColor = [UIColor whiteColor];
    self.chooseClassTXF.placeholder = @"请选择您要关联的学生所在的班级";
    [self addSubview:self.chooseClassTXF];
    
    lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 59, kScreenWidth-20, 1)];
    lineView2.backgroundColor = COLOR(221, 221, 221, 1);
    [self addSubview:lineView2];
    
    self.chooseStudentTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 60,kScreenWidth-20 , 30)];
    self.chooseStudentTXF.delegate = self;
    self.chooseStudentTXF.backgroundColor = [UIColor whiteColor];
    self.chooseStudentTXF.placeholder = @"请选择您要关联的学生";
    [self addSubview:self.chooseStudentTXF];
    
    lineView3 = [[UIView alloc] initWithFrame:CGRectMake(10, 89, kScreenWidth-20, 1)];
    lineView3.backgroundColor = COLOR(221, 221, 221, 1);
    [self addSubview:lineView3];
    
    self.relationTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 90,kScreenWidth-20 , 30)];
    self.relationTXF.backgroundColor = [UIColor whiteColor];
    self.relationTXF.placeholder = @"请选择您和该学生的关系";
    [self addSubview:self.relationTXF];
    
    
    lineView2.hidden = YES;
    lineView3.hidden = YES;
    self.chooseClassTXF.hidden = YES;
    self.chooseStudentTXF.hidden = YES;
    self.relationTXF.top = 30;

    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.top = 0;
//    }];
    
}
- (void)showChooseClass{
    lineView2.hidden = NO;
    self.chooseClassTXF.hidden = NO;
    self.relationTXF.top = 60;
}
- (void)showChooseStudent{
    lineView3.hidden = NO;
    self.chooseStudentTXF.hidden = NO;
    self.relationTXF.top = 90;
}
- (void)cancleAction:(UIButton *)sender{
    [self dissmiss];
}
- (void)dissmiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.top = kScreenHeight;
    }];
}

- (void)btnAction:(UIButton *)sender{
    [self dissmiss];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if([textField isEqual:_chooseSchTXF]){
        if(self.chooseSchBlock){
            self.chooseSchBlock();
        }
    }
    if([textField isEqual:_chooseClassTXF]){
        if(self.chooseClassBlock){
            self.chooseClassBlock();
        }
    }
    if([textField isEqual:_chooseStudentTXF]){
        if(self.chooseStudentBlock){
            self.chooseStudentBlock();
        }
    }
}


@end
