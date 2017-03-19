//
//  DatePickerHeadView.h
//  UIDatePicker的使用
//
//  Created by faith on 15/8/19.
//  Copyright (c) 2015年 faith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerHeadView : UIView

- (void)addTarget:(id)target confirmAction:(SEL)action;
- (void)addTarget:(id)target cancelAction:(SEL)action;

@end
