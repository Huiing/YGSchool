//
//  YGNoticeDetailVC.m
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGNoticeDetailVC.h"
#import "YGCommon.h"
@interface YGNoticeDetailVC ()
@property(nonatomic, strong)UILabel *contentLbl;
@property(nonatomic, strong)UIImageView *imageView;
@end

@implementation YGNoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    self.rightBtn.hidden = YES;
    [self addSubViews];
}
- (void)addSubViews{
    self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 20)];
    self.contentLbl.numberOfLines = 0;
    self.contentLbl.lineBreakMode = NSLineBreakByWordWrapping; //自动换行
    self.contentLbl.font = [UIFont systemFontOfSize:16];
    NSString *content = self.dic[@"desc"];
    CGSize s = [content textSizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(kScreenWidth - 60, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    self.contentLbl.text = content;
    self.contentLbl.height = s.height;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.contentLbl.bottom+10, kScreenWidth - 30, 100)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"img"]] placeholderImage:[UIImage imageNamed:@"i4"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = image.size;
        NSLog(@"%f %f",size.width,size.height);
        self.imageView.height = self.imageView.width*size.height/size.width;
    }];
//    [itemBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imags[index]]] placeholderImage:[UIImage imageNamed:@"i1"]];
//    self.imageView.image = [UIImage imageNamed:@"i4"];
    [self.view addSubview:self.contentLbl];
    [self.view addSubview:self.imageView];
}

@end
