//
//  YGSwipeVC.h
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBaseViewController.h"
#import "YGChooseControl.h"

@interface YGSwipeVC : YGBaseViewController
@property(nonatomic,strong) YGChooseControl *chooseControl;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
