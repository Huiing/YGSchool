//
//  YGLeaveListItem.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGLeaveListItem.h"

@implementation YGLeaveListItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"leaveId":@"leave_id",@"studentId":@"student_id",@"studentName":@"student_name"};
}

@end
