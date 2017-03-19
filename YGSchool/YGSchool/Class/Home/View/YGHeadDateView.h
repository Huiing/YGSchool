//
//  YGHeadDateView.h
//  AddOrSubDate
//
//  Created by faith on 17/2/17.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGHeadDateView : UIView
@property(nonatomic, strong)UILabel *timeLbl;
@property(nonatomic, strong)UIButton *previous;
@property(nonatomic, strong)UIButton *nest;
@property(nonatomic, strong)NSDate *currentDate;
@property(nonatomic, strong)UIButton *randomBtn;
@end
