//
//  YGSignListVC.h
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBaseViewController.h"
#import "YGHomeWorkListItem.h"
#import "YGSegmentControl.h"
@interface YGSignListVC : YGBaseViewController
@property(nonatomic, strong)YGHomeWorkListItem *item;
@property(nonatomic, strong, readonly) YGSegmentControl   *segmentControl;
@property(nonatomic, strong, readonly) UIScrollView       *scrollView;

//  segment properties
@property(nonatomic)            XHSegmentType   segmentType;
@property(nonatomic, strong)    UIImage         *segmentBackgroundImage;
@property(nonatomic, strong)    UIColor         *segmentBackgroundColor;
@property(nonatomic)            CGFloat         segmentLineWidth;      //  linewidth > 0，底部高亮线
@property(nonatomic, strong)    UIColor         *segmentHighlightColor;
@property(nonatomic, strong)    UIColor         *segmentBorderColor;
@property(nonatomic)            CGFloat         segmentBorderWidth;
@property(nonatomic, strong)    UIColor         *segmentTitleColor;
@property(nonatomic, strong)    UIFont          *segmentTitleFont;
@property(nonatomic, strong)    NSArray         *viewControllers;

@end
