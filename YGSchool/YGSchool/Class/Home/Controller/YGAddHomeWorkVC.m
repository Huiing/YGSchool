//
//  YGAddHomeWorkVC.m
//  YGSchool
//
//  Created by faith on 17/2/18.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGAddHomeWorkVC.h"
#import "YGCommon.h"
@interface YGAddHomeWorkVC ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *imageArray;
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
    NSString *classId;
}
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)YGBoardView *addHomeWorkView;
@property(nonatomic, strong) UITextField *courseTXF;
@property(nonatomic, strong) UITextField *classTXF;
@property(nonatomic, strong) UITextField *dateTXF;
@property(nonatomic, strong) UITextView *contentTXV;
@property(nonatomic, strong) UILabel *placeholderLabel;
@property(nonatomic, strong) YGPhotoCollectionView *collectionView;
@property(nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) CGFloat localProgress;
@property (nonatomic,assign) float percent;
@property (nonatomic,strong) MDPieView *pieView;

@end

@implementation YGAddHomeWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"添加作业";
    self.rightBtn.hidden = YES;
    imageArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = COLOR_WITH_HEX(0xebeef3);
    [self addSubViews];
}
- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54)];
        _scrollView.contentSize = CGSizeMake(0, kScreenHeight - 53);
        _scrollView.showsVerticalScrollIndicator = FALSE;
    }
    return _scrollView;
    
}
- (void)addSubViews{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.addHomeWorkView];
    [self addTXF];
    _contentTXV = [[UITextView alloc] initWithFrame:CGRectMake(5, 91, kScreenWidth - 40, 110)];
    _contentTXV.delegate = self;
    [self.addHomeWorkView addSubview:_contentTXV];
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
    _placeholderLabel.textColor = COLOR(200, 200, 200, 1);
    _placeholderLabel.font = [UIFont systemFontOfSize:18];
    _placeholderLabel.text = @"内容";
    [_contentTXV addSubview:_placeholderLabel];
    
    UILabel *pictureLbl = [[UILabel alloc] initWithFrame:CGRectMake(45, 250, 100, 20)];
    pictureLbl.font = [UIFont systemFontOfSize:14];
    pictureLbl.text = @"图片";
    [self.scrollView addSubview:pictureLbl];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    CGFloat h = (kScreenWidth-150-10)/2;
    _collectionView = [[YGPhotoCollectionView alloc] initWithFrame:CGRectMake(45, 280, kScreenWidth-150, h) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.imageArr = imageArray;
    __block YGAddHomeWorkVC *weakself  = self;
    _collectionView.addBlock = ^{
        NSLog(@"++");
//        weakself.pieView = [[MDPieView alloc]initWithFrame:CGRectMake(50, 100, 100, 100) andPercent:weakself.percent andColor:[UIColor blueColor]];
//        weakself.pieView.center = weakself.collectionView.iconImage.center;
//        [weakself.collectionView.iconImage addSubview:weakself.pieView];
//        weakself.percent = 1;
//        [weakself.pieView reloadViewWithPercent:weakself.percent];

        [weakself openMenu];
    };
//    _collectionView.delectBlock = ^(NSInteger index){
//        NSLog(@"--");
//        //        [imageArray removeObjectAtIndex:index];
//        //
//        [weakself.collectionView reloadData];
//    };
    
    [self.scrollView addSubview:_collectionView];
    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(45, _collectionView.bottom + 40, kScreenWidth - 90, 30)];
    _confirmBtn.layer.cornerRadius = 7;
    [_confirmBtn.layer setMasksToBounds:YES];
    [_confirmBtn setBackgroundColor:COLOR_WITH_HEX(0x4285d4)];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_confirmBtn];
    
    //日期选择
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
    pickerView.dateFormat = @"yyyy-MM-dd";
    headView = pickerView.headView;
    [headView addTarget:self confirmAction:@selector(confirm:)];
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [self.view addSubview:pickerView];
    pickerView.hidden = YES;


}
- (void)confirmAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    if ([_courseTXF.text length] ==0) {
        alertMessage = @"请选择课程";
    }else if ([_classTXF.text length] ==0){
        alertMessage = @"请选择班级";
    }else if ([_dateTXF.text length] ==0){
        alertMessage = @"请选择日期";
    }else if ([_contentTXV.text length] ==0){
        alertMessage = @"请填写内容";
    }else if ([imageArray count] ==0){
        alertMessage = @"请上传图片";
    }else{
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:@"homeworkEdit" forKey:@"event_code"];
        [parameter setObject:@"" forKey:@"account_id"];
        [parameter setObject:@"" forKey:@"class_id"];
        [parameter setObject:@"schoolList" forKey:@"date"];
        [parameter setObject:@"" forKey:@"course "];
        [parameter setObject:@"" forKey:@"desc"];
        [parameter setObject:@"" forKey:@"imgs"];
        [YGNetWorkManager addHomeworkWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        } fail:^{
            
        }];
        return;
    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *resultStr = pickerView.resultStr;
    if (resultStr == nil) {
        resultStr = dateStr;
    }
    _dateTXF.text = resultStr;
    pickerView.hidden = YES;
}

- (void)cancle:(UIButton *)sender {
    pickerView.hidden = YES;
}

- (void)addTXF{
    _courseTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 40, 30)];
    _courseTXF.delegate = self;
    _courseTXF.font = [UIFont systemFontOfSize:16];
    _courseTXF.placeholder = @"选择课程";
    [self.addHomeWorkView addSubview:_courseTXF];
    _classTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 40, 30)];
    _classTXF.delegate = self;
    _classTXF.font = [UIFont systemFontOfSize:16];
    _classTXF.placeholder = @"班级";
    [self.addHomeWorkView addSubview:_classTXF];
    _dateTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, kScreenWidth - 40, 30)];
    _dateTXF.delegate = self;
    _dateTXF.font = [UIFont systemFontOfSize:16];
    _dateTXF.placeholder = @"日期";
    [self.addHomeWorkView addSubview:_dateTXF];

}
- (YGPhotoCollectionView *)collectionView{
    if(!_collectionView){
        
    }
    return _collectionView;
}
- (YGBoardView *)addHomeWorkView{
    if(!_addHomeWorkView){
        _addHomeWorkView = [[YGBoardView alloc] initWithFrame:CGRectMake(40, 40, kScreenWidth - 80, 200)];
        [_addHomeWorkView setLineNumber:3];
        [_addHomeWorkView setCorner:UIRectCornerAllCorners];
    }
    return _addHomeWorkView;
}
//调用相册～
-(void)openMenu{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相机
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }];
        [alertController addAction:defaultAction];
    }
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action){
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:defaultAction1];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [self result:[info objectForKey:UIImagePickerControllerOriginalImage] percent:0.0001];
    [imageArray addObject:image];
    NSInteger imageCount = imageArray.count + 1;
    NSInteger row = imageCount/2;
    if(imageCount%2 != 0){
        row++;
    }
    CGFloat h = row * (kScreenWidth-150-10)/2 + 10 * (row-1);
    _collectionView.height = h;
    _confirmBtn.top = _collectionView.bottom + 40;
    if(_confirmBtn.bottom > kScreenHeight - 54){
        _scrollView.contentSize = CGSizeMake(0, _confirmBtn.bottom + 60);
        _scrollView.contentOffset = CGPointMake(0, _confirmBtn.bottom + 54 + 20 - kScreenHeight);

    }
    [_collectionView reloadData];
    
}
//压缩图片质量
-(UIImage *)result:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]){
    _placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        _placeholderLabel.hidden = NO;
    }
    return YES;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([textField isEqual:_courseTXF]){
        [textField resignFirstResponder];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"选择课程",@"语文",@"数学",@"英语",@"科学"];
        shadeView.chooseBlock = ^(NSString *title){
            _courseTXF.text = title;
            [weakShadeView dissmiss];
        };
        [self.view.window addSubview:shadeView];
    }
    if([textField isEqual:_classTXF]){
        [textField resignFirstResponder];
        YGShadeView *shadeView = [[YGShadeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        __block YGShadeView *weakShadeView  = shadeView;
        shadeView.titleArray = @[@"班级",@"小学一年级(01)班",@"小学一年级(02)班",@"小学二年级(01)班",@"小学二年级(02)班",@"小学三年级(01)班",@"小学三年级(02)班",@"小学四年级(01)班",@"小学四年级(02)班",@"小学五年级(01)班",@"小学五年级(02)班",@"小学六年级(01)班",@"小学六年级(02)班"];
        shadeView.chooseBlock = ^(NSString *title){
            _classTXF.text = title;
            [weakShadeView dissmiss];
        };
        [self.view.window addSubview:shadeView];
    }
    if([textField isEqual:_dateTXF]){
        [textField resignFirstResponder];
        [self showDatePick];
    }

}
// 显示DatePick
- (void)showDatePick {
    pickerView.hidden = NO;
    [pickerView bringSubviewToFront:pickerView.headView];
    [pickerView bringSubviewToFront:pickerView.datePickerView];
    [self.view bringSubviewToFront:pickerView];
    
}
- (void)getClassList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"classList" forKey:@"event_code"];
    [dic setObject:@"classList" forKey:@"school_id"];
    [YGNetWorkManager getSchoolListWithParameter:dic completion:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
//        _classArray = responseObject[@"list"];
    } fail:^{
        NSLog(@"");
    }];
    
}

@end