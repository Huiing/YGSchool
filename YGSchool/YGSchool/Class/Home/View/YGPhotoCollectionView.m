//
//  YGPhotoCollectionView.m
//  YGSchool
//
//  Created by faith on 17/2/18.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGPhotoCollectionView.h"
#import "YGCommon.h"
@interface YGPhotoCollectionView()
@property (nonatomic,assign) float percent;
@property (nonatomic,strong) MDPieView *pieView;
@end
@implementation YGPhotoCollectionView
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout ];
//    self.layer.cornerRadius = (kScreenWidth-150-10)/4;
//    [self.layer setMasksToBounds:YES];

    if(self)
    {
        [self config];
    }
    return self;
}
- (void)config
{
    self.dataSource=self;
    self.delegate=self;
    [self setBackgroundColor:[UIColor whiteColor]];
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    UICollectionViewCell * cell = [[UICollectionViewCell alloc] init];
    _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth-150-10)/2, (kScreenWidth-150-10)/2)];
    [cell addSubview:_iconImage];
    if(indexPath.row < _imageArr.count)
    {
//        self.layer.cornerRadius = (kScreenWidth-150-10)/4;
//        [self.layer setMasksToBounds:YES];
        if([_imageArr[indexPath.row] isKindOfClass:[NSString class]])
        {
            _iconImage.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    
        }
        else
        {
            _iconImage.image = _imageArr[indexPath.row];
            self.pieView = [[MDPieView alloc]initWithFrame:CGRectMake(50, 100, 100, 100) andPercent:self.percent andColor:[UIColor blueColor]];
            self.pieView.center = _iconImage.center;
            [_iconImage addSubview:self.pieView];
            self.percent = 1;
            [self.pieView reloadViewWithPercent:self.percent];


            
            

        }
        UIImageView *delectImage = [[UIImageView alloc] initWithFrame:CGRectMake(_iconImage.right - 20, _iconImage.top, 20, 20)];
        delectImage.image = [UIImage imageNamed:@"delect"];
        [cell addSubview:delectImage];
        
    }
    else if(indexPath.row ==_imageArr.count)
    {
        //        iconImage.backgroundColor = [UIColor redColor];
        _iconImage.image = [UIImage imageNamed:@"add.jpg"];
    }
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-150-10)/2, (kScreenWidth-150-10)/2);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==_imageArr.count && self.addBlock)
    {
        self.addBlock();
    }
//    if(indexPath.row < _imageArr.count && self.delectBlock)
//    {
//        [_imageArr removeObject:_imageArr[indexPath.row]];
//        self.delectBlock(indexPath.row);
//        
//    }
    
}

@end
