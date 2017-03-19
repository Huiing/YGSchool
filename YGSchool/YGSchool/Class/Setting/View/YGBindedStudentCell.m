//
//  YGBindedStudentCell.m
//  YGSchool
//
//  Created by faith on 17/2/23.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBindedStudentCell.h"
#import "YGCommon.h"

@interface YGBindedStudentCell()
@property(nonatomic, strong)UILabel *nameLbl;
@property(nonatomic, strong)UILabel *schoolLbl;
@property(nonatomic, strong)UILabel *classLbl;
@end
@implementation YGBindedStudentCell

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

- (void)addSubViews{
    self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,kScreenWidth - 10 , 15)];
    self.schoolLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 30,kScreenWidth - 10 , 15)];
    self.nameLbl.font = [UIFont systemFontOfSize:14];

    self.schoolLbl.font = [UIFont systemFontOfSize:14];
    self.schoolLbl.textColor = COLOR(175, 175, 175, 1);
    
    self.classLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 50,kScreenWidth - 10 , 15)];
    self.classLbl.font = [UIFont systemFontOfSize:14];
    self.classLbl.textColor = COLOR(175, 175, 175, 1);
    [self addSubview:self.nameLbl];
    [self addSubview:self.schoolLbl];
    [self addSubview:self.classLbl];
    self.nameLbl.text = @"测试学生2";
    self.schoolLbl.text = [NSString stringWithFormat:@"学校: %@",@"塘下镇罗凤小学"];
    self.classLbl.text = [NSString stringWithFormat:@"班级: %@",@"小学六年级(02)班"];}

@end
