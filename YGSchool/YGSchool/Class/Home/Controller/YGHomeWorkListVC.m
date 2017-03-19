//
//  YGHomeWorkListVC.m
//  YGSchool
//
//  Created by faith on 17/2/17.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGHomeWorkListVC.h"
#import "YGCommon.h"
// For Parent
#define DefaultSegmentHeight 44
@interface YGHomeWorkListVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, XHSegmentControlDelegate,UIAlertViewDelegate>
{
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
    YGHeadDateView *headDateView;
    UIView *backgroundView;
    NSArray *timeArray;
    NSString *timeStr;
    NSArray *studentArray;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITableView *tableView2;
// For Parent
@property(nonatomic, strong) YGSegmentControl   *segmentControl;
@property(nonatomic)         CGFloat        beginOffsetX;
@property(nonatomic, strong) UIScrollView   *scrollView;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) NSArray   *homeWorkList;

@end

@implementation YGHomeWorkListVC
- (void)initData{
    timeArray = [NSArray array];
    studentArray = [NSArray array];
    timeStr = [NSString string];

}
- (NSArray *)homeWorkList{
    if(!_homeWorkList){
        _homeWorkList = [[NSArray alloc] init];
    }
    return _homeWorkList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业列表";
    self.rightBtn.left -= 20;
    self.rightBtn.width += 20;
    [self initData];
//    [self addSubViews];
//    [self.rightBtn setTitle:@"添加作业" forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(addHomeWork:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    headDateView = [[YGHeadDateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
//    [headDateView.randomBtn addTarget:self action:@selector(randomBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:headDateView];
//    
//    //日期选择
//    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
//    pickerView.dateFormat = @"yyyy年MM月dd日";
//    headView = pickerView.headView;
//    [headView addTarget:self confirmAction:@selector(confirm:)];
//    [headView addTarget:self cancelAction:@selector(cancle:)];
//    [self.view addSubview:pickerView];
//    pickerView.hidden = YES;
//    
//    self.rightBtn.hidden = YES;
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.title = @"测试学生";
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.title = @"学生1";
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.title = @"测试学生2";
//    self.viewControllers = @[vc1, vc2, vc3];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:self.segmentControl];
//    [self.view addSubview:self.scrollView];
    
    [self getMyStudentList];
//    [self queryHomework];

//    if([YGLDataManager manager].userData.userType == UserTypeParent){
//        self.rightBtn.hidden = YES;
//        UIViewController *vc1 = [[UIViewController alloc] init];
//        vc1.title = @"测试学生";
//        UIViewController *vc2 = [[UIViewController alloc] init];
//        vc2.title = @"学生1";
//        UIViewController *vc3 = [[UIViewController alloc] init];
//        vc3.title = @"测试学生2";
//        self.viewControllers = @[vc1, vc2, vc3];
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.view.backgroundColor = [UIColor purpleColor];
//        [self.view addSubview:self.segmentControl];
//        [self.view addSubview:self.scrollView];
//        //  监听contentScrollView
////        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    }else{
//        [self.view addSubview:self.tableView];
//        [YGShow fullSperatorLine:self.tableView];
//    }
}
- (void)addSubViews{
    self.rightBtn.left -= 20;
    self.rightBtn.width += 20;
    [self.rightBtn setTitle:@"添加作业" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(addHomeWork:) forControlEvents:UIControlEventTouchUpInside];
    
    
    headDateView = [[YGHeadDateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    [headDateView.randomBtn addTarget:self action:@selector(randomBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headDateView];
    
    //日期选择
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
    pickerView.dateFormat = @"yyyy年MM月dd日";
    headView = pickerView.headView;
    [headView addTarget:self confirmAction:@selector(confirm:)];
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [self.view addSubview:pickerView];
    pickerView.hidden = YES;
    
    self.rightBtn.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];


}
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, kScreenHeight-90) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UITableView *)tableView2{
    if(!_tableView2)
    {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 79, kScreenWidth, kScreenHeight-79) style:UITableViewStylePlain];
        _tableView2.tag = 2;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        [self.view addSubview:_tableView2];
    }
    return _tableView2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_tableView.tag ==1){
        return self.homeWorkList.count;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.homeWorkList[indexPath.row];
    CGFloat imageH = (kScreenWidth - 160)/2;
    NSArray *imgs = dic[@"imgs"];
    NSInteger imageCount = imgs.count;
    CGFloat containerH = imageCount/2*(5 + imageH);
    if(imageCount%2!=0){
        containerH = (imageCount/2+1)*(5 + imageH);
    }
    NSString *content = dic[@"desc"];
//    NSString *content = @"庆历四年春，滕子京谪守巴陵郡。越明年，政通人和，百废具兴。乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属予作文以记之。";
    
    
    CGSize s = [content textSizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(kScreenWidth - 60, 10000) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat h = 25 + containerH + 25 + s.height + 10;

    return h;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"YGHomeWorkListCell2";
    YGHomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[YGHomeWorkListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    __block YGHomeWorkListVC *weakself  = self;
    cell.enlargeImageBlock = ^(NSInteger index){
        backgroundView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [backgroundView addGestureRecognizer:tap];
        backgroundView.frame = CGRectMake(0, 0,kScreenWidth,kScreenHeight);
        backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        backgroundView.alpha = 0.8;
        [weakself.view.window addSubview:backgroundView];
        UIImageView *largeImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, kScreenWidth - 60, 350)];
        //        largeImage.backgroundColor = colorArr[index];
//        largeImage.image = imageArr[index];
        [backgroundView addSubview:largeImage];
        
    };
    cell.editBlock = ^{
        NSLog(@"+++");
        YGEditHomeWorkVC *editHomeWorkVC = [[YGEditHomeWorkVC alloc] init];
        editHomeWorkVC.dic = self.homeWorkList[indexPath.row];
        editHomeWorkVC.dateString = headDateView.timeLbl.text;
//        editHomeWorkVC.imageArray = imageArr;
        [self.navigationController pushViewController:editHomeWorkVC animated:YES ];
    };
    cell.delectBlock = ^{
        NSLog(@"----");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"你确认么?" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alertView show];
    };
    cell.signBlock = ^{
        YGSignListVC *signListVC = [[YGSignListVC alloc] init];
//        signListVC.item = item;
        [self presentViewController:signListVC animated:YES completion:nil];
        };

    NSDictionary *dic = self.homeWorkList[indexPath.row];
    
    [cell setDic:dic];
    return cell;
    
//    if(tableView.tag ==1){
//        static NSString *identify = @"YGHomeWorkListCell2";
//        YGHomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//        if(!cell){
//            cell = [[YGHomeWorkListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//        }
//        NSDictionary *dic = self.homeWorkList[indexPath.row];
//
//        [cell setDic:dic];
//    }

//    static NSString *identify = @"YGHomeWorkListCell";
//    YGHomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//    if(!cell){
//        cell = [[YGHomeWorkListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//    }
//    YGHomeWorkListItem *item = [[YGHomeWorkListItem alloc] init];
//    item.course = @"英语";
////    item.classes= @"初一年级(03)班";
//    NSMutableArray *imageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"i1"],[UIImage imageNamed:@"i2"],[UIImage imageNamed:@"i3"], nil];
//    item.imgs = imageArr;
////    item.content = @"庆历四年春，滕子京谪守巴陵郡。越明年，政通人和，百废具兴。乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属予作文以记之。";
//    __block YGHomeWorkListVC *weakself  = self;
//    cell.enlargeImageBlock = ^(NSInteger index){
//        backgroundView = [[UIView alloc] init];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [backgroundView addGestureRecognizer:tap];
//        backgroundView.frame = CGRectMake(0, 0,kScreenWidth,kScreenHeight);
//        backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
//        backgroundView.alpha = 0.8;
//        [weakself.view.window addSubview:backgroundView];
//        UIImageView *largeImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, kScreenWidth - 60, 350)];
////        largeImage.backgroundColor = colorArr[index];
//        largeImage.image = imageArr[index];
//        [backgroundView addSubview:largeImage];
//        
//    };
//    cell.editBlock = ^{
//        NSLog(@"+++");
//        YGEditHomeWorkVC *editHomeWorkVC = [[YGEditHomeWorkVC alloc] init];
//        editHomeWorkVC.item = item;
//        editHomeWorkVC.dateString = headDateView.timeLbl.text;
//        editHomeWorkVC.imageArray = imageArr;
//        [self presentViewController:editHomeWorkVC animated:YES completion:nil];
//    };
//    cell.delectBlock = ^{
//        NSLog(@"----");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"你确认么?" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
//        [alertView show];
//    };
//    cell.signBlock = ^{
//        YGSignListVC *signListVC = [[YGSignListVC alloc] init];
//        signListVC.item = item;
//        [self presentViewController:signListVC animated:YES completion:nil];
//    };
//    [cell setItem:item];
//    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 补全分割线
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
    timeStr = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
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
- (void)tapAction:(UITapGestureRecognizer *)sender{
    [backgroundView removeFromSuperview];
}
- (void)addHomeWork:(UIButton *)sender{
    YGAddHomeWorkVC *addHomeWork = [[YGAddHomeWorkVC alloc] init];
    [self presentViewController:addHomeWork animated:YES completion:nil];
}

// For Parent
#pragma mark - Private Method

- (void)selectNext
{
    if (self.segmentControl.selectIndex + 1 < self.viewControllers.count) {
        
        self.segmentControl.selectIndex = self.segmentControl.selectIndex + 1;
    }
}

- (void)selectPrevious
{
    if (self.segmentControl.selectIndex > 0) {
        
        self.segmentControl.selectIndex = self.segmentControl.selectIndex - 1;
    }
}

#pragma mark - lazy initializer
- (YGSegmentControl *)segmentControl
{
    if (!_segmentControl)
    {
        CGFloat y = 35;
        _segmentControl = [[YGSegmentControl alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, DefaultSegmentHeight)];
        _segmentControl.delegate = self;
    }
    return _segmentControl;
}

- (UIScrollView *)scrollView
{
    //  scrollView
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_segmentControl.frame))];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.decelerationRate = 0.5;
        _scrollView.delegate = self;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
#pragma mark - Setters

- (void)setSegmentType:(XHSegmentType)segmentType
{
    _segmentType = segmentType;
    self.segmentControl.segmentType = segmentType;
}

- (void)setSegmentBackgroundColor:(UIColor *)segmentBackgroundColor
{
    _segmentBackgroundColor = segmentBackgroundColor;
    self.segmentControl.backgroundColor = segmentBackgroundColor;
}

- (void)setSegmentBackgroundImage:(UIImage *)segmentBackgroundImage
{
    _segmentBackgroundImage = segmentBackgroundImage;
    self.segmentControl.backgroundImage = segmentBackgroundImage;
}

- (void)setSegmentHighlightColor:(UIColor *)segmentHighlightColor
{
    _segmentHighlightColor = segmentHighlightColor;
    self.segmentControl.highlightColor = segmentHighlightColor;
}

- (void)setSegmentLineWidth:(CGFloat)segmentLineWidth
{
    _segmentLineWidth = segmentLineWidth;
    self.segmentControl.lineWidth = segmentLineWidth;
}

- (void)setSegmentBorderWidth:(CGFloat)segmentBorderWidth
{
    _segmentBorderWidth = segmentBorderWidth;
    self.segmentControl.borderWidth = segmentBorderWidth;
}

- (void)setSegmentBorderColor:(UIColor *)segmentBorderColor
{
    _segmentBorderColor = segmentBorderColor;
    self.segmentControl.borderColor = segmentBorderColor;
}

- (void)setSegmentTitleColor:(UIColor *)segmentTitleColor
{
    _segmentTitleColor = segmentTitleColor;
    self.segmentControl.titleColor = segmentTitleColor;
}

- (void)setSegmentTitleFont:(UIFont *)segmentTitleFont
{
    _segmentTitleFont = segmentTitleFont;
    self.segmentControl.titleFont = segmentTitleFont;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *child, NSUInteger idx, BOOL * _Nonnull stop) {
        [child removeFromParentViewController];
    }];
    
    //  initialize
    NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
    for (UIViewController *c in self.viewControllers) {
        [arrayTitle addObject:c.title];
    }
    self.segmentControl.titles = arrayTitle;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.viewControllers.count, CGRectGetHeight(self.scrollView.frame));
    [self.segmentControl load];
}

#pragma mark - XHSegmentControlDelegate
- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation
{
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [controller removeFromParentViewController];
     }];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    //  add controller
    UIViewController *controller = self.viewControllers[index];
    
    //  add view
    UIView *view = controller.view;
    [view removeFromSuperview];
    view.frame = CGRectMake(index * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [self.scrollView addSubview:view];
    
    //  add next view
    if (index + 1 < self.viewControllers.count) {
        UIViewController *nextController = self.viewControllers[index + 1];
        UIView *nextView = nextController.view;
        [nextView removeFromSuperview];
        nextView.frame = CGRectMake((index + 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:nextView];
    }
    
    //  add previous view
    if (index - 1 >= 0) {
        UIViewController *previousController = self.viewControllers[index - 1];
        UIView *previousView = previousController.view;
        [previousView removeFromSuperview];
        [self.scrollView addSubview:previousView];
        previousView.frame = CGRectMake((index - 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    }
    
    if(index ==0){
        view.backgroundColor = [UIColor grayColor];
    }else if(index ==1){
        view.backgroundColor = [UIColor blueColor];
    }else{
        view.backgroundColor = [UIColor greenColor];
    }
    [self.scrollView scrollRectToVisible:view.frame animated:animation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!scrollView.isDecelerating) {
        
        self.beginOffsetX = CGRectGetWidth(scrollView.frame) * self.segmentControl.selectIndex;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat targetX = targetContentOffset->x;
    NSInteger selectIndex = targetX/CGRectGetWidth(self.scrollView.frame);
    self.segmentControl.selectIndex = selectIndex;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:@"homeworkDel" forKey:@"event_code"];
        [parameter setObject:@"" forKey:@"account_id"];
        [parameter setObject:@"" forKey:@"homework_id"];
        [YGNetWorkManager delectHomeworkWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"");
        } fail:^{
            
        }];
    }else{
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSchoolList];
}
- (void)getSchoolList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"schoolList" forKey:@"event_code"];
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    [d setObject:dic forKey:@"content"];
    [YGNetWorkManager getSchoolListWithParameter:d completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
//        _schoolArray = responseObject[@"list"];
    } fail:^{
        NSLog(@"");
    }];
}
- (void)getStudentList{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"studentList" forKey:@"event_code"];
    [parameter setObject:@"studentList" forKey:@"account_id"];
    [parameter setObject:@"studentList" forKey:@"class_id"];
    [YGNetWorkManager getStudentListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } fail:^{
        
    }];
}
- (void)getMyStudentList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"myStudentList" forKey:@"event_code"];
    [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [YGNetWorkManager getMyStudentListWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if([responseObject[@"code"] integerValue] ==1){
            studentArray = responseObject[@"list"];
            NSMutableArray *vcs = [[NSMutableArray alloc] init];
            for(int i = 0;i <studentArray.count;i++){
                NSDictionary *studentDic = studentArray[i];
                UIViewController *vc = [[UIViewController alloc] init];
                vc.title = studentDic[@"name"];
                [vcs addObject:vc];
                
            }
            [self addSubViews];
            self.viewControllers = vcs;
            [self queryHomework];
            

        }
    } fail:^{
        
    }];
}
- (void)queryHomework{
    NSDictionary *studentDic = studentArray[_currentIndex];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"homeworkSearch" forKey:@"event_code"];
    [dic setObject:[YGLDataManager manager].userData.accountID forKey:@"account_id"];
    if([timeStr isEqualToString:@""]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        timeStr = dateStr;

    }
    [dic setObject:timeStr forKey:@"date"];
    [dic setObject:studentDic[@"student_id"] forKey:@"student_id"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSString *str = [YGTools convertToJsonString:dic];
    [parameter setObject:str forKey:@"content"];

    [YGNetWorkManager queryHomeworkWithParameter:parameter completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if([responseObject[@"code"] integerValue] == 1){
            self.homeWorkList = responseObject[@"dt"];
            [self.tableView2 reloadData];
        }
    } fail:^{
        
    }];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentOffset"] && !self.scrollView.isDecelerating && self.scrollView.isDragging) {
//        
//        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
//        CGFloat rate = (contentOffset.x - self.beginOffsetX)/CGRectGetWidth(self.scrollView.
//                                                                            frame);
//        [self.segmentControl scrollToRate:rate];
//    }
//}

@end
