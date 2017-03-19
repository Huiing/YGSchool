//
//  YGHomeWorkListItem.m
//  YGSchool
//
//  Created by faith on 17/2/17.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGHomeWorkListItem.h"

@implementation YGHomeWorkListItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"homeworkId":@"homework_id",@"classId":@"class_id",@"className":@"class_name"};
}

@end
