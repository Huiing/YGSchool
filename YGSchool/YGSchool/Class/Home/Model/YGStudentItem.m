//
//  YGStudentItem.m
//  YGSchool
//
//  Created by faith on 17/3/2.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGStudentItem.h"

@implementation YLLocation
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"locWay":@"loc_way",@"olonlat":@"o_lonlat"};
}

@end

@implementation YGStudentItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"studentId":@"student_id",@"deviceType":@"device_type",@"headIcon":@"head_icon"};
}

@end
