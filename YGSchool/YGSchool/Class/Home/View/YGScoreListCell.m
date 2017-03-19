//
//  YGScoreListCell.m
//  YGSchool
//
//  Created by faith on 17/3/7.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGScoreListCell.h"

@implementation YGScoreListCell

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
- (UILabel *)nameLbl{
    if(!_nameLbl){
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 44)];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLbl;
}
- (UILabel *)courseLbl{
    if(!_courseLbl){
        _courseLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, 44)];
        _courseLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _courseLbl;
}
- (UILabel *)typeLbl{
    if(!_typeLbl){
        _typeLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/4, 44)];
        _typeLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLbl;
}
- (UILabel *)scoreLbl{
    if(!_scoreLbl){
        _scoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4*3, 0, kScreenWidth/4, 44)];
        _scoreLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _scoreLbl;
}

- (void)addSubViews{
    [self addSubview:self.nameLbl];
    [self addSubview:self.courseLbl];
    [self addSubview:self.typeLbl];
    [self addSubview:self.scoreLbl];
}
- (void)setItem:(YGScoreItem *)item{
    _item = item;
    _nameLbl.text = item.name;
    _courseLbl.text = item.course;
    _typeLbl.text = item.type;
    _scoreLbl.text = item.score;
}
@end
