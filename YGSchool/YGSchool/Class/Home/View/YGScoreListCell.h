//
//  YGScoreListCell.h
//  YGSchool
//
//  Created by faith on 17/3/7.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGCommon.h"
@interface YGScoreListCell : UITableViewCell
@property(nonatomic, strong)UILabel *nameLbl;
@property(nonatomic, strong)UILabel *courseLbl;
@property(nonatomic, strong)UILabel *typeLbl;
@property(nonatomic, strong)UILabel *scoreLbl;
@property(nonatomic, strong)YGScoreItem *item;
@end
