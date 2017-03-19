//
//  YGScheduleItem.h
//  YGSchool
//
//  Created by faith on 17/3/2.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGScheduleItem : NSObject
@property (nonatomic, copy) NSString                                *scheduleId;
@property (nonatomic, copy) NSString                                *week;
@property (nonatomic, copy) NSString                                *time;
@property (nonatomic, copy) NSString                                *part;
@property (nonatomic, copy) NSString                                *course;
@end
