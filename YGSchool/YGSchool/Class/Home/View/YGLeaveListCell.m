//
//  YGLeaveListCell.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGLeaveListCell.h"
#import "YGCommon.h"
@interface YGLeaveListCell()
@property(nonatomic, strong)UILabel *reasonLbl;
@property(nonatomic, strong)UILabel *dayNumberLbl;
@property(nonatomic, strong)UILabel *startDateLbl;
@property(nonatomic, strong)UILabel *applyDateLbl;
@property(nonatomic, strong)UILabel *studentLbl;
@property(nonatomic, strong)UILabel *statusLbl;

@end
@implementation YGLeaveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}
- (UILabel *)reasonLbl{
    if(!_reasonLbl){
        _reasonLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,kScreenWidth - 10 , 15)];
        _reasonLbl.font = [UIFont systemFontOfSize:14];
    }
    return _reasonLbl;
}
- (UILabel *)dayNumberLbl{
    if(!_dayNumberLbl){
        _dayNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 15)];
        _dayNumberLbl.font = [UIFont systemFontOfSize:14];
    }
    return _dayNumberLbl;
}
- (UILabel *)startDateLbl{
    if(!_startDateLbl){
        _startDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 45,kScreenWidth - 10 , 15)];
        _startDateLbl.font = [UIFont systemFontOfSize:14];
    }
    return _startDateLbl;
}
- (UILabel *)applyDateLbl{
    if(!_applyDateLbl){
        _applyDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, kScreenWidth - 10, 15)];
        _applyDateLbl.font = [UIFont systemFontOfSize:14];
    }
    return _applyDateLbl;
}
- (UILabel *)studentLbl{
    if(!_studentLbl){
        _studentLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, kScreenWidth - 10, 15)];
        _studentLbl.font = [UIFont systemFontOfSize:14];
    }
    return _studentLbl;
}
- (UILabel *)statusLbl{
    if(!_statusLbl){
        _statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 25, 80, 20)];
        _statusLbl.font = [UIFont systemFontOfSize:14];
    }
    return _statusLbl;
}
- (void)addSubViews{
    [self addSubview:self.reasonLbl];
    [self addSubview:self.dayNumberLbl];
    [self addSubview:self.startDateLbl];
    [self addSubview:self.applyDateLbl];
    [self addSubview:self.studentLbl];
    [self addSubview:self.statusLbl];
}
- (void)setItem:(YGLeaveListItem *)item{
    _item = item;
    self.reasonLbl.text = [NSString stringWithFormat:@"请假事由:%@",@"有事"];
    self.dayNumberLbl.text = [NSString stringWithFormat:@"请假时长:%@",@"3天"];
    self.startDateLbl.text = [NSString stringWithFormat:@"开始日期:%@",@"2017-02-09"];
    self.applyDateLbl.text = [NSString stringWithFormat:@"申请时间:%@",@"2017-02-09"];
    self.studentLbl.text = [NSString stringWithFormat:@"学生:%@",@"测试学生"];
    self.statusLbl.text = [NSString stringWithFormat:@"状态:%@",@"未批准"];

}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.reasonLbl.text = [NSString stringWithFormat:@"请假事由:%@",dic[@"desc"]];
    self.dayNumberLbl.text = [NSString stringWithFormat:@"请假时长:%@天",dic[@"days"]];
    self.startDateLbl.text = [NSString stringWithFormat:@"开始日期:%@",dic[@"date"]];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:dic[@"date"]];
    NSInteger days = [dic[@"days"] integerValue];
    NSTimeInterval  interval =24*60*60*days; //1:天数
//    NSDate *date2 = [date1 initWithTimeIntervalSinceNow:+interval];
    NSDate *date3 = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date1];
    NSString *dateString2 = [dateFormatter stringFromDate:date3];


    self.applyDateLbl.text = [NSString stringWithFormat:@"申请时间:%@",dateString2];
    self.studentLbl.text = [NSString stringWithFormat:@"学生:%@",dic[@"student_name"]];
    NSString *status = [dic[@"status"] integerValue]?@"批准":@"未批准";
    self.statusLbl.text = [NSString stringWithFormat:@"状态:%@",status];

}
@end
