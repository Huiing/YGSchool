//
//  YGAlbumListCell.m
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGAlbumListCell.h"
#import "YGCommon.h"

@interface YGAlbumListCell()
@property(nonatomic, strong)UILabel *titleLbl;
@property(nonatomic, strong)UILabel *photoNumberLbl;
@property(nonatomic, strong)UILabel *timeLbl;
@property(nonatomic, strong)UILabel *nameLbl;
@property(nonatomic, strong)UIButton *moreBtn;
@property(nonatomic, strong)UIImageView *imageView1;
@property(nonatomic, strong)UIImageView *imageView2;


@end

@implementation YGAlbumListCell

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
    self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,100 , 15)];
    self.titleLbl.font = [UIFont systemFontOfSize:14];
    self.titleLbl.text = NSTextAlignmentLeft;
    self.photoNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 25,100 , 15)];
    self.photoNumberLbl.font = [UIFont systemFontOfSize:14];
    self.photoNumberLbl.text = NSTextAlignmentLeft;
    self.timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 45,200 , 15)];
    self.timeLbl.font = [UIFont systemFontOfSize:14];
    self.timeLbl.text = NSTextAlignmentLeft;

//    self.nameLbl.textColor = COLOR(175, 175, 175, 1);
    self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 65,100 , 15)];
    self.nameLbl.font = [UIFont systemFontOfSize:14];
    self.nameLbl.text = NSTextAlignmentLeft;
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40 , 40, 20 , 20)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self addSubview:self.titleLbl];
    [self addSubview:self.photoNumberLbl];
    [self addSubview:self.timeLbl];
    [self addSubview:self.nameLbl];
    [self addSubview:self.moreBtn];
    self.titleLbl.text = @"测试2";
    self.photoNumberLbl.text = @"3张图片";
    self.timeLbl.text = @"16/12/19 12:40";
    self.nameLbl.text = @"周林";
    CGFloat iw = (kScreenWidth-220)/2;
    CGFloat iy = (85 - iw)/2;
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(130, iy, iw, iw)];
    self.imageView1.image = [UIImage imageNamed:@"123.jpeg"];
    [self addSubview:self.imageView1];
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(130+iw+10, iy, iw, iw)];
    self.imageView2.image = [UIImage imageNamed:@"124.jpg"];
    [self addSubview:self.imageView2];

}
- (void)setItem:(YGAlbumListItem *)item{
    _item = item;
}
@end
