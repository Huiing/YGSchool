//
//  YGHomeWorkListCell.h
//  YGSchool
//
//  Created by faith on 17/2/17.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGHomeWorkListItem.h"
typedef void (^EnlargeImageBlock)(NSInteger);
typedef void (^EditBlock)();
typedef void (^DelectBlock)();
typedef void (^SignBlock)();
@interface YGHomeWorkListCell : UITableViewCell
@property(nonatomic, strong)YGHomeWorkListItem *item;
@property(nonatomic, strong)EditBlock editBlock;
@property(nonatomic, strong)DelectBlock delectBlock;
@property(nonatomic, strong)SignBlock signBlock;
@property(nonatomic, strong)EnlargeImageBlock enlargeImageBlock;
@property(nonatomic, strong)NSDictionary *dic;
@end
