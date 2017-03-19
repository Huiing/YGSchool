//
//  NSObject+utilty.h
//  YGSchool
//
//  Created by faith on 17/3/6.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (utilty)
- (NSString *)Zero;
- (BOOL)isNumber;//是否是纯数字
- (BOOL)isPhoneNumber;//是否手机号码
- (BOOL)isQQNumber;//是否QQ号
- (BOOL)isEmpty; //是否为空

@end
