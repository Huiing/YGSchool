//
//  HourPickerView.m
//  YLDGPS
//
//  Created by user on 15/8/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "HourPickerView.h"
#import "YGCommon.h"
#import <ReactiveCocoa.h>

@interface HourPickerView (){
    BOOL isShow;
    BOOL isAnimating;
}
@property (nonatomic, strong) UIButton          *alphaBKBtn;
@property (nonatomic, strong) UIView            *pickerBK;
@property (nonatomic, strong) UIPickerView      *hourPicker;
@property (nonatomic, strong) UIButton          *confirmBtn;
@end

@implementation HourPickerView

#pragma mark - life cyle
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self addSubview:self.alphaBKBtn];
    [self addSubview:self.pickerBK];
    [self.pickerBK addSubview:self.hourPicker];
    [self.pickerBK addSubview:self.confirmBtn];
    
    self.hidden = !isShow;
    
    [self rac];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(isAnimating) return;
    
    CGRect frame = self.superview.bounds;
    self.frame = frame;
    
    self.alphaBKBtn.frame = frame;
    
    frame.size.height = 220;
    frame.origin.y = isShow?(self.frame.size.height - frame.size.height):(self.frame.size.height + frame.size.height);
    self.pickerBK.frame = frame;
    
    frame.origin.y = 5;
    frame.size.height = 162;
    frame.origin.x = 10;
    frame.size.width = self.pickerBK.frame.size.width - frame.origin.x*2;
    self.hourPicker.frame = frame;
    
    frame.origin.y = CGRectGetMaxY(frame) + 5;
    frame.size.height = 35;
    frame.origin.x = 40;
    frame.size.width = self.pickerBK.frame.size.width - frame.origin.x*2;
    self.confirmBtn.frame = frame;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger row = 0;
    switch (component) {
        case 0:
            row = 24*600;
            break;
            
        case 1:
            row = 1;
            break;
            
        case 2:
            row = 60*600;
            break;
            
        case 3:
            row = 1;
            break;
            
        default:
            break;
    }
    return row;
}

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *tittle = @"";
    switch (component) {
        case 0:
            tittle = [NSString stringWithFormat:@"%ld", (long)row%24];
            break;
            
        case 1:
            tittle = @"小时";
            break;
            
        case 2:
            tittle = [NSString stringWithFormat:@"%ld", (long)row%60];
            break;
            
        case 3:
            tittle = @"分钟";
            break;
            
        default:
            break;
    }
    
    return tittle;
}

#pragma mark - public methods
- (void)show{
    if(isShow || isAnimating) return;
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        isAnimating = YES;
        self.alphaBKBtn.alpha = 0.5;
        CGRect frame = self.pickerBK.frame;
        frame.origin.y = self.frame.size.height - frame.size.height;
        self.pickerBK.frame = frame;
    } completion:^(BOOL finished) {
        isAnimating = NO;
        isShow = YES;
    }];
}

- (void)hiden{
    if(!isShow || isAnimating) return;
    [UIView animateWithDuration:0.3 animations:^{
        isAnimating = YES;
        self.alphaBKBtn.alpha = 0;
        CGRect frame = self.pickerBK.frame;
        frame.origin.y = self.frame.size.height + frame.size.height;
        self.pickerBK.frame = frame;
    } completion:^(BOOL finished) {
        isAnimating = NO;
        isShow = NO;
        self.hidden = YES;
    }];
}

#pragma mark - private methods
- (void)rac{
    @weakify(self);
    [[self.alphaBKBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self hiden];
    }];
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.hour  = [[self pickerView:self.hourPicker titleForRow:[self.hourPicker selectedRowInComponent:0] forComponent:0] integerValue];
        self.minute = [[self pickerView:self.hourPicker titleForRow:[self.hourPicker selectedRowInComponent:2] forComponent:2] integerValue];
        if([self.delegate respondsToSelector:@selector(hourPickerConfirm:)]){
            [self.delegate hourPickerConfirm:self];
        }
        [self hiden];
    }];
}

#pragma mark - getters and setters
- (void)setHour:(NSInteger)hour{
    if(hour >  24){
        hour = 23;
    }
    if(hour < 0){
        hour = 0;
    }
    _hour = hour;
    [_hourPicker selectRow:(300*24 + hour) inComponent:0 animated:NO];
}

- (void)setMinute:(NSInteger)minute{
    if(minute >  59){
        minute = 59;
    }
    if(minute < 0){
        minute = 0;
    }
    _minute = minute;
    [_hourPicker selectRow:(300*60 + minute) inComponent:2 animated:NO];
}

- (UIButton*)alphaBKBtn{
    if(_alphaBKBtn == nil){
        _alphaBKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alphaBKBtn.backgroundColor = [UIColor grayColor];
        _alphaBKBtn.alpha = isShow?0.5:0;
    }
    return _alphaBKBtn;
}

- (UIView*)pickerBK{
    if(_pickerBK == nil){
        _pickerBK = [[UIView alloc] init];
        _pickerBK.backgroundColor = [UIColor whiteColor];
    }
    return _pickerBK;
}

- (UIPickerView*)hourPicker{
    if(_hourPicker == nil){
        _hourPicker = [[UIPickerView alloc] init];
        _hourPicker.dataSource = self;
        _hourPicker.delegate = self;
        [_hourPicker selectRow:300*24 inComponent:0 animated:NO];
        [_hourPicker selectRow:300*60 inComponent:2 animated:NO];
    }
    return _hourPicker;
}

- (UIButton*)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = COLOR_WITH_HEX(0x3C9ED2);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _confirmBtn.layer.cornerRadius = 4;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    }
    return _confirmBtn;
}

@end
