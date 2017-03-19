//
//  YGPhotoCollectionView.h
//  YGSchool
//
//  Created by faith on 17/2/18.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AddBlock)();
typedef void(^DelectPhotoBlock)(NSInteger index);
@interface YGPhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic , retain)NSMutableArray *imageArr;
@property (nonatomic ,copy)AddBlock addBlock;
@property (nonatomic ,copy)DelectPhotoBlock delectPhotoBlock;
@property (nonatomic,strong)UIImageView *iconImage;
@end
