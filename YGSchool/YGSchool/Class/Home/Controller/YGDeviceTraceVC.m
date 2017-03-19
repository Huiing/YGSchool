//
//  YGDeviceTraceVC.m
//  YGSchool
//
//  Created by faith on 17/3/8.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGDeviceTraceVC.h"
#import "YGCommon.h"
@interface YGDeviceTraceVC ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation YGDeviceTraceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineView.backgroundColor = COLOR(200, 200, 200, 1);
    [self.view addSubview:lineView];
    [self initMapView];
}
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.mapView setZoomLevel:15 animated:NO];
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.view addSubview:self.mapView];
    }
}

@end
