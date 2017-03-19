//
//  YLDGridView.m
//  YLDGPS
//
//  Created by faith on 17/3/10.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YLDGridView.h"
#import "YGCommon.h"

@interface YLDGridView()
@end
@implementation YLDGridView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        [self addSubViews];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)addSubViews{
    [self addSubview:self.icon];
    [self addSubview:self.titleLbl];
}
- (UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake((kGirdWidth-88)/2, kGirdHeight/2-30, 88, 53)];
        
    }
    return _icon;
}
- (UILabel *)titleLbl{
    if(!_titleLbl){
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake((kGirdWidth-60)/2, _icon.bottom +10, 60, 20)];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:12];
        _titleLbl.textColor = COLOR_WITH_HEX(0x333333);
    }
    return _titleLbl;
}
- (void)setTitleImage:(NSString *)titleImage{
    _titleImage = titleImage;
    _icon.image = [UIImage imageNamed:titleImage];
    _titleLbl.text = titleImage;
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.didSelectedBlock){
        self.didSelectedBlock(self.tag);
    }
}

@end
