//
//  YGHomeVC.m
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGHomeVC.h"
#import "YGCommon.h"

@interface YGHomeVC ()
{
    NSArray *dataArray;
}
@property(nonatomic, strong) UIImageView *profileImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) NSArray *titleArray;


@end

@implementation YGHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云谷学堂";
    dataArray = @[@"作业",@"考勤",@"成绩",@"GPS",@"请假",@"公告通知"];
    [self addSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = COLOR_WITH_HEX(0x814b20);
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationController.navigationBar.barTintColor = COLOR_WITH_HEX(0xeb893b);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    left.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(left:)];
    [left addGestureRecognizer:tap];
    left.image = [UIImage imageNamed:@"头像"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    right.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(right:)];
    [right addGestureRecognizer:tap2];
    right.image = [UIImage imageNamed:@"设置"];
    left.image = [UIImage imageNamed:@"头像"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];

}
- (NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = [[NSArray alloc] initWithObjects:@"作业",@"考勤",@"成绩",@"GPS",@"请假",@"公告",@"奖惩",@"课表",@"相册", nil];
    }
    return _titleArray;
}

- (void)left:(UITapGestureRecognizer *)tap{
    
}
- (void)right:(UITapGestureRecognizer *)tap{
    YGSettingVC *settingVC = [[YGSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)left{
    
}
- (UIImageView *)profileImageView{
    if(!_profileImageView){
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 80)/2, 30+20, 80, 80)];
        _profileImageView.userInteractionEnabled = YES;
        _profileImageView.image = [UIImage imageNamed:@"profile_default"];
        _profileImageView.layer.cornerRadius = 40;
        [_profileImageView.layer setMasksToBounds:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_profileImageView addGestureRecognizer:tap];
        
    }
    return _profileImageView;
}
- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-120)/2, 140, 120, 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}
- (void)addSubViews{
//    [self.view addSubview:self.profileImageView];
//    [self.view addSubview:self.nameLabel];
//    [self middleView];
    [self initGridView];
    
    
    
}
- (void)initGridView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KMapHeight, kScreenWidth, kScreenHeight-KMapHeight)];
    [self.view addSubview:bgView];
    for (int index=0; index<9; index++) {
        int totalColumns = 3;
        int row=index/totalColumns;
        int col=index%totalColumns;
        int appW = kGirdWidth;
        int appH = kGirdHeight;
        
        YLDGridView *gridView = [[YLDGridView alloc]init];
        gridView.tag = index;
        gridView.frame = CGRectMake(col*appW, row*appH, appW, appH);
        gridView.titleLbl.text = self.titleArray[index];
        gridView.icon.image = [UIImage imageNamed:self.titleArray[index]];
        gridView.didSelectedBlock = ^(NSInteger tag){
            UIViewController* vc = nil;
            switch (tag) {
                case 0:
                    vc = [[YGHomeWorkListVC alloc] init];
                    break;
                case 1:
                    vc = [[YGAttendanceVC alloc] init];
                    break;
                case 2:
                {
                    vc = [[YGScoreVC alloc] init];
                }
                    break;
                case 3:
                    vc = [[YGGPSVC alloc] init];
                    break;
                case 4:
                    vc = [[YGLeaveVC alloc] init];
                    break;
                case 5:
                    vc = [[YGNoticeVC alloc] init];
                    break;
                case 6:
                    vc = [[YGRewardPunishmentVC alloc] init];
                    break;
                case 7:
                    vc = [[YGScheduleVC alloc] init];
                    break;
                case 8:
                    vc = [[YGAlbumVC alloc] init];
                    break;

                default:
                    break;
            }
        [self.navigationController pushViewController:vc animated:YES];
        };
        [bgView addSubview:gridView];
    }
    for(int i = 0; i < 4; i ++){
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i*kGirdHeight, kScreenWidth, 1)];
        lineView.backgroundColor = SeparatorLine_COLOR;
        [bgView addSubview:lineView];
    }
    for(int j = 1; j <3; j++){
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(j*kGirdWidth, 0, 1, kScreenHeight - KMapHeight - 64)];
        lineView.backgroundColor = SeparatorLine_COLOR;
        [bgView addSubview:lineView];
    }
    
    
}
@end
