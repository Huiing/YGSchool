//
//  YGLeaveListCell.h
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGLeaveListItem.h"
@interface YGLeaveListCell : UITableViewCell
@property(nonatomic, strong)YGLeaveListItem *item;
@property(nonatomic, strong)NSDictionary *dic;
@end
