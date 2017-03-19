//
//  YGLeaveShadeView.h
//  YGSchool
//
//  Created by faith on 17/2/23.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGBoardView.h"
typedef void(^ClickBlock)(NSInteger );
typedef void (^ChooseStudentBlock)();
typedef void (^ChooseDateBlock)();

@interface YGLeaveShadeView : UIView<UITextFieldDelegate>
@property(nonatomic, strong)YGBoardView *boardView;
@property(nonatomic, strong)UITextField *chooseStudentTXF;
@property(nonatomic, strong)UITextField *chooseDateTXF;
@property(nonatomic, strong)UITextField *leaveDaysTXF;
@property(nonatomic, strong)UITextField *reasonTXF;
@property(nonatomic, strong)ClickBlock clickBlock;
@property(nonatomic, strong)ChooseStudentBlock chooseStudentBlock;
@property(nonatomic, strong)ChooseDateBlock chooseDateBlock;
- (void)dissmiss;
@end
