//
//  YGSwipeVC.m
//  YGSchool
//
//  Created by faith on 17/2/21.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGSwipeVC.h"
#import "YGCommon.h"
@interface YGSwipeVC ()
@end

@implementation YGSwipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBtn.hidden = YES;
    _chooseControl = [[YGChooseControl alloc] initWithFrame:CGRectMake(40, 16, kScreenWidth - 80, 35)];
    [self.view addSubview:_chooseControl];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, kScreenWidth, 1)];
    lineView.backgroundColor = COLOR(200, 200, 200, 1);
    [self.view addSubview:lineView];
    // 添加左右手势
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];

}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if([_chooseControl.currentBtn isEqual:_chooseControl.second]){
            return;
        }
        _chooseControl.currentBtn = _chooseControl.second;
        [_chooseControl secondIsSelected];
        NSLog(@"往左滑");
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if([_chooseControl.currentBtn isEqual:_chooseControl.first]){
            return;
        }
        _chooseControl.currentBtn = _chooseControl.first;
        [_chooseControl firstIsSelected];
        NSLog(@"往右滑");
    }
}

@end
