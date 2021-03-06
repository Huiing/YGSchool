//
//  YGEditAlbumVC.m
//  YGSchool
//
//  Created by faith on 17/2/22.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGEditAlbumVC.h"
#import "YGCommon.h"
@interface YGEditAlbumVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong) YGBoardView *boardView;
@property(nonatomic, strong) UITextField *nameTXF;
@property(nonatomic, strong) UITextField *classTXF;
@property(nonatomic, strong) YGPhotoCollectionView *collectionView;
@property(nonatomic, strong) UIButton *confirmBtn;

@end

@implementation YGEditAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLbl.text = @"编辑相册";
    self.rightBtn.hidden = YES;
    self.view.backgroundColor = COLOR_WITH_HEX(0xebeef3);
//    [self addSubViews];

}
- (void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
    [self addSubViews];
    [self refreshView];
}
//- (NSMutableArray *)imageArray{
//    if(!_imageArray){
//        _imageArray = [[NSMutableArray alloc] init];
//    }
//    return _imageArray;
//}
- (YGBoardView *)boardView{
    if(!_boardView){
        _boardView = [[YGBoardView alloc] initWithFrame:CGRectMake(40, 40, kScreenWidth - 80, 60)];
        [_boardView setLineNumber:2];
        [_boardView setCorner:UIRectCornerAllCorners];
    }
    return _boardView;
}
- (void)addSubViews{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.boardView];
    [self addTXF];
    UILabel *pictureLbl = [[UILabel alloc] initWithFrame:CGRectMake(45, 110, 100, 20)];
    pictureLbl.font = [UIFont systemFontOfSize:14];
    pictureLbl.text = @"图片";
    [self.scrollView addSubview:pictureLbl];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    CGFloat h = (kScreenWidth-150-10)/2;
    _collectionView = [[YGPhotoCollectionView alloc] initWithFrame:CGRectMake(45, 140, kScreenWidth-150, h) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.imageArr = self.imageArray;
    __block YGEditAlbumVC *weakself  = self;
    _collectionView.addBlock = ^{
        NSLog(@"++");
        
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
    [self.scrollView addSubview:_confirmBtn];
}
- (void)addTXF{
    _nameTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 100, 30)];
    _nameTXF.font = [UIFont systemFontOfSize:16];
    _nameTXF.placeholder = @"名称";
    _nameTXF.text = self.contentTitle;
    [self.boardView addSubview:_nameTXF];
    _classTXF = [[UITextField alloc] initWithFrame:CGRectMake(10, 31, kScreenWidth - 100, 30)];
    _classTXF.font = [UIFont systemFontOfSize:16];
    _classTXF.placeholder = @"班级";
    _classTXF.delegate = self;
    _classTXF.text = self.className;
    [self.boardView addSubview:_classTXF];
}
- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54)];
        _scrollView.contentSize = CGSizeMake(0, kScreenHeight - 53);
        _scrollView.showsVerticalScrollIndicator = FALSE;
    }
    return _scrollView;
    
}
- (void)confirmAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    NSString *alertMessage;
    if ([_nameTXF.text length] ==0) {
        alertMessage = @"请输入名称";
    }else if ([_classTXF.text length] ==0){
        alertMessage = @"请选择班级";
    }else if(_imageArray.count>0){
        alertMessage = @"请上传图片";
    }else{
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:@"photoAdd" forKey:@"event_code"];
        [parameter setObject:@"photoAdd" forKey:@"account_id"];
        [parameter setObject:@"photoAdd" forKey:@"photo_id"];
        [parameter setObject:@"photoAdd" forKey:@"title"];
        [parameter setObject:@"photoAdd" forKey:@"imgs"];
        [YGNetWorkManager editAlbumWithParameter:parameter completion:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        } fail:^{
            
        }];
        return;
    }
    alert.message = alertMessage;
    [self presentViewController:alert animated:YES completion:nil];
    
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
    [self.imageArray addObject:image];
    [self refreshView];
    
}
- (void)refreshView{
    NSInteger imageCount = self.imageArray.count + 1;
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
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
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
    
}

@end
