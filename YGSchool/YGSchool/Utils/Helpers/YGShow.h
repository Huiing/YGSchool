//
//  YGShow.h
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YGShow : NSObject
typedef void(^isLoginBlock)();
+(void)showRootViewController;
+ (void)StatusWithObj:(id )obj withStr:(NSString *)str isSuccessBlock:(isLoginBlock)isSuccessBlock isErrorBlock:(isLoginBlock)isErrorBlock;
+ (void)hideHUD;

+ (void)showError:(NSString *)error;
+ (void)toLogin;
#pragma mark - 补全分割线
+ (void)fullSperatorLine:(UITableView *)tableView;
@end
