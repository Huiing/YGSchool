//
//  YGAlbumVC.h
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGBaseViewController.h"
#import "MWPhotoBrowser.h"
@interface YGAlbumVC : YGBaseViewController<MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@end
