//
//  YLDGridView.h
//  YLDGPS
//
//  Created by faith on 17/3/10.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidSelectedBlock)(NSInteger tag);
@interface YLDGridView : UIView
@property(nonatomic, strong)UIImageView *icon;
@property(nonatomic, strong)UILabel *titleLbl;
@property(nonatomic, strong) NSString *titleImage;
@property(nonatomic, strong) DidSelectedBlock didSelectedBlock;
@end
