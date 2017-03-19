//
//  deviceTrackViewModel.m
//  YLDGPS
//
//  Created by user on 15/7/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "deviceTrackViewModel.h"

@implementation deviceTrackViewModel
@synthesize startTime = _startTime;
@synthesize endTime   = _endTime;

#pragma mark - public methods
///获取设备轨迹
- (void)getDeviceTrack {
//    NSString *filterLBS = self.isFilterLBS?@"1":@"0";
//    [YLDAPIManager getDeviceTrackWithDeviceID:self.deviceID filterLBS:filterLBS beginTime:self.startTime endTime:self.endTime success:^(id responseObject) {
//        BOOL r = [responseObject[@"r"] boolValue];
//        NSString *msg = responseObject[@"msg"];
//        if(r){
//            NSArray *dt = responseObject[@"dt"];
//            self.locations = dt;
//        }
//        self.msg = msg;
//        self.r = r;
//    } fail:^(NSError *error) {
//        self.msg = error.localizedDescription;
//        self.r = NO;
//    }];
}

#pragma mark - getters and setters
- (NSString*)startTime{
    if(_startTime == nil){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        _startTime = [NSString stringWithFormat:@"%.0f000", [calendar dateFromComponents:components].timeIntervalSince1970];
    }
    return _startTime;
}

- (NSString*)endTime{
    if(_endTime == nil){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        _endTime = [NSString stringWithFormat:@"%.0f000", ([calendar dateFromComponents:components].timeIntervalSince1970 + 24*60*60 - 1)];
    }
    return _endTime;
}

- (void)setLocations:(NSArray *)locations{
    _locations = locations;
}

- (void)setR:(BOOL)r{
    _r = r;
}

- (void)setMsg:(NSString *)msg{
    _msg = msg;
}

@end
