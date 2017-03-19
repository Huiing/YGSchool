//
//  YGShadeView.h
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChooseBlock)(NSString *);
@interface YGShadeView : UIView
@property(nonatomic,strong)ChooseBlock chooseBlock;
@property(nonatomic,copy)NSString *title;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong)UITableView *tableView;
- (void)dissmiss;
@end
