//
//  HourPickerView.h
//  YLDGPS
//
//  Created by user on 15/8/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HourPickerDlegate;

@interface HourPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign) NSInteger                 hour;
@property (nonatomic, assign) NSInteger                 minute;
@property (nonatomic, weak)   id<HourPickerDlegate>     delegate;

- (void)show;
- (void)hiden;
@end

@protocol HourPickerDlegate <NSObject>
@optional
- (void)hourPickerConfirm:(HourPickerView*)hourPicker;
@end