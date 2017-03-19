//
//  YGStudentItem.h
//  YGSchool
//
//  Created by faith on 17/3/2.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YLLocation : NSObject
@property (nonatomic, copy) NSString                                *locWay;
@property (nonatomic, copy) NSString                                *lonlat;
@property (nonatomic, copy) NSString                                *olonlat;
@property (nonatomic, copy) NSString                                *bdlonlat;
@property (nonatomic, copy) NSString                                *speed;
@property (nonatomic, copy) NSString                                *direct;
@property (nonatomic, copy) NSString                                *times;
@property (nonatomic, copy) NSString                                *address;
@end

@interface YGStudentItem : NSObject
@property (nonatomic, strong) YLLocation *location;
@property (nonatomic, copy) NSString *studentId;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *online;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *headIcon;



@end
