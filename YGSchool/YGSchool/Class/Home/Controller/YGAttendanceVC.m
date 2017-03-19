//
//  YGAttendanceVC.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGAttendanceVC.h"
#import "YGCommon.h"
@interface YGAttendanceVC (){
    YGHeadDateView *headDateView;
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
}
@property(nonatomic, strong)UISegmentedControl *seg;
@end

@implementation YGAttendanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤";
    self.rightBtn.hidden = YES;
    headDateView = [[YGHeadDateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    [headDateView.randomBtn addTarget:self action:@selector(randomBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headDateView];
    //日期选择
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
    headView = pickerView.headView;
    [headView addTarget:self confirmAction:@selector(confirm:)];
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [self.view addSubview:pickerView];
    pickerView.hidden = YES;
    [self.view addSubview:self.seg];

}
- (UISegmentedControl *)seg{
    if(!_seg){
        NSArray *array = [NSArray arrayWithObjects:@"测试学生",@"学生2",@"测试45", nil];
        _seg = [[UISegmentedControl alloc]initWithItems:array];
        _seg.frame = CGRectMake(50, 60, kScreenWidth-100, 30);
    }
    return _seg;
}
- (void)randomBtn:(UIButton *)sender{
    [self showDatePick];
}
// 显示DatePick
- (void)showDatePick {
    pickerView.hidden = NO;
    [pickerView bringSubviewToFront:pickerView.headView];
    [pickerView bringSubviewToFront:pickerView.datePickerView];
    [self.view bringSubviewToFront:pickerView];
    
}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *resultStr = pickerView.resultStr;
    if (resultStr == nil) {
        resultStr = dateStr;
    }
    NSArray *arr = [resultStr componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[arr[2] integerValue]];
    [_comps setMonth:[arr[1] integerValue]];
    [_comps setYear:[arr[0] integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSLog(@"_weekday::%@",[self getWeekDayByWeek:_weekday]);
    
    resultStr = [NSString stringWithFormat:@"%@ %@",resultStr,[self getWeekDayByWeek:_weekday]];
    
    
    
    
    headDateView.timeLbl.text = resultStr;
    //    if(isDeadLineTime)
    //    {
    //        _footVc2.deadLine.text = resultStr;
    //    }
    //    else
    //    {
    //        _footVc2.wantGetGoodTime.text = resultStr;
    //    }
    pickerView.hidden = YES;
    
}

- (void)cancle:(UIButton *)sender {
    pickerView.hidden = YES;
}
- (NSString *)getWeekDayByWeek:(NSInteger)week{
    switch (week) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    return nil;
    
}

@end
