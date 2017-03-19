//
//  YGSegmentItem.h
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Item_Padding     20
@interface YGSegmentItem : UIButton
@property(nonatomic, strong)           NSString  *title;
@property(nonatomic, strong)           UIColor  *highlightColor;
@property(nonatomic, strong)           UIColor  *titleColor;
@property(nonatomic, strong)           UIFont   *titleFont;

+ (CGFloat)caculateWidthWithtitle:(NSString *)title titleFont:(UIFont *)titleFont;
- (void)refresh;
+ (BOOL)isStringEmpty:(NSString *)text;
@end
