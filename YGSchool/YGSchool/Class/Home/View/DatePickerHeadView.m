//
//  DatePickerHeadView.m
//  UIDatePicker的使用
//
//  Created by faith on 15/8/19.
//  Copyright (c) 2015年 faith. All rights reserved.
//

#import "DatePickerHeadView.h"
@interface DatePickerHeadView()
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@end
@implementation DatePickerHeadView

- (void)addTarget:(id)target confirmAction:(SEL)action
{
  [self.confirmBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)addTarget:(id)target cancelAction:(SEL)action
{
  [self.cancleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}



@end
