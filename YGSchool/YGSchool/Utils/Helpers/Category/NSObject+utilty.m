//
//  NSObject+utilty.m
//  YGSchool
//
//  Created by faith on 17/3/6.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "NSObject+utilty.h"

@implementation NSObject (utilty)
// <null>转空格
-(NSString *)Zero{
    if ([[NSString stringWithFormat:@"%@",self] isEqualToString:@"<null>"]) {
        return @"";
    }
    if ([[NSString stringWithFormat:@"%@",self] length] == 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@",self];
}
/**
 *  判断内容是否是数字
 *
 *  @return YES为都是数字，NO为不是数字
 */
#pragma mark -- 判断是否为数字
-(BOOL)isNumber
{
    //设置筛选条件
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:[self Zero] options:0 range:NSMakeRange(0, [self Zero].length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}
/**
 *  验证是否是手机号码
 *
 *  @return YES为是 NO为不是
 */
#pragma mark -- 判断是否为手机号
-(BOOL)isPhoneNumber
{
    //手机号筛选
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[1][358][0-9]{9}" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:[self Zero] options:0 range:NSMakeRange(0,[self Zero].length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

/**
 *  是否是QQ号
 *
 *  @return 是返回YES
 */
#pragma mark -- 判断是否为QQ号
-(BOOL)isQQNumber
{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]{5,15}$" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:[self Zero] options:0 range:NSMakeRange(0, [self Zero].length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}
- (BOOL)isEmpty{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if([self isKindOfClass:[NSString class]]){
        NSString *strObj = (NSString *)self;
        if ([[strObj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
    }
    return NO;
}

@end
