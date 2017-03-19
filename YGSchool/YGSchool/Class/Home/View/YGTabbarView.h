//
//  YGTabbarView.h
//  YGSchool
//
//  Created by faith on 17/3/8.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YGTabbarDelegate;
@interface YGTabbarView : UIImageView
@property (nonatomic, strong) NSArray                   *itemTitles;
@property (nonatomic, assign) id<YGTabbarDelegate>     delegate;
@end
@protocol YGTabbarDelegate <NSObject>
@optional
- (void)tabBardidSelectIndex:(NSInteger)index;
@end
