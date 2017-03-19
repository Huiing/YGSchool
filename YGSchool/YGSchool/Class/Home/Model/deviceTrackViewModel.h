//
//  deviceTrackViewModel.h
//  YLDGPS
//
//  Created by user on 15/7/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface deviceTrackViewModel : NSObject
@property (nonatomic, copy) NSString                                *deviceID;
@property (nonatomic, assign, readonly) BOOL                        isFilterLBS;
@property (nonatomic, copy, readonly) NSString                      *startTime;
@property (nonatomic, copy, readonly) NSString                      *endTime;
@property (nonatomic, strong, readonly) NSArray                     *locations;         ///坐标数组 轨迹
@property (nonatomic, assign, readonly) BOOL                        r;
@property (nonatomic, copy, readonly) NSString                      *msg;
///获取设备轨迹
- (void)getDeviceTrack;
@end
