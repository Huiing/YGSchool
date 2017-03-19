//
//  DatePickerView.h
//  xixun
//
//  Created by faith on 15/9/17.
//  Copyright (c) 2015年 3N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerHeadView.h"

@interface DatePickerView : UIView
@property (nonatomic,strong) NSString           *dateFormat;
@property (nonatomic,strong) NSString           *resultStr;
@property (nonatomic,strong) UIDatePicker       *datePickerView;
@property (nonatomic,strong) DatePickerHeadView *headView;
- (void)setMaximumDate:(NSDate *)date;
- (void)setMinimumDate:(NSDate *)date;
- (void)setDate:(NSString *)dateStr;
@end
