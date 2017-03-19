//
//  YGAddBindShadeView.h
//  YGSchool
//
//  Created by faith on 17/2/23.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChooseSchBlock)();
typedef void (^ChooseClassBlock)();
typedef void (^ChooseStudentBlock)();
@interface YGAddBindShadeView : UIView
@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)UITextField *chooseSchTXF;
@property(nonatomic, strong)UITextField *chooseClassTXF;
@property(nonatomic, strong)UITextField *chooseStudentTXF;
@property(nonatomic, strong)UITextField *relationTXF;
@property(nonatomic, strong)UIButton *confirmBtn;
@property(nonatomic, strong)UIButton *cancleBtn;
@property(nonatomic, strong)ChooseSchBlock  chooseSchBlock;
@property(nonatomic, strong)ChooseClassBlock  chooseClassBlock;
@property(nonatomic, strong)ChooseStudentBlock  chooseStudentBlock;

- (void)showChooseClass;
- (void)showChooseStudent;
@end
