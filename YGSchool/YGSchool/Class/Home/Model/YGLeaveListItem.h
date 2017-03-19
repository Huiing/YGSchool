//
//  YGLeaveListItem.h
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGLeaveListItem : NSObject
@property(nonatomic, copy) NSString *leaveId;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *studentId;
@property(nonatomic, copy) NSString *classId;
@property(nonatomic, copy) NSString *studentName;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *days;
@property(nonatomic, copy) NSString *desc;
@end
