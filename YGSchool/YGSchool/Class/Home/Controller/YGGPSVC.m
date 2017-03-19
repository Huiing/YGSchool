//
//  YGGPSVC.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//
#define DefaultSegmentHeight 44
#import "YGGPSVC.h"
#import "YGCommon.h"

@interface YGGPSVC ()<UIActionSheetDelegate,MarkerInfoViewDelegate,MAMapViewDelegate, AMapLocationManagerDelegate>
{
    NSTimer      *countDownTimer;
    NSInteger    countdownTime;
}
@property(nonatomic)         CGFloat            beginOffsetX;
@property(nonatomic, strong) UIScrollView       *scrollView;
@property (nonatomic,strong)CLLocation *currentLocation;

@property (nonatomic, strong) UIButton              *zoomInButton;              //放大按钮
@property (nonatomic, strong) UIButton              *zoomOutButton;             //缩小按钮
@property (nonatomic, strong) UIButton              *satelliteButton;           //卫星地图按钮
@property (nonatomic, strong) UIButton              *buildingsButton;           //3d建筑按钮
@property (nonatomic, strong) UIButton              *preButton;                 //上一个
@property (nonatomic, strong) UIButton              *nextButton;                //下一个
@property (nonatomic, assign) BOOL                  isShowPanorama;
@property (nonatomic, strong) UILabel               *countDownTimeLabel;        //倒计时label
@property (nonatomic, strong) MarkerInfoView        *markInfoView;
@property (nonatomic, strong) UIView    *currentView;
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;

@end

@implementation YGGPSVC
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    //设置允许连续定位逆地理
//    [self.locationManager setLocatingWithReGeocode:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS定位";
    self.rightBtn.hidden = YES;
//    [self addSubViews];
    
//    [AMapServices sharedServices].enableHTTPS = YES;
    
    
    [self initMapView];
    
    [self configLocationManager];
    [self addSubViews];

//    self.locationManager = [[AMapLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
//    self.service = [[BMKLocationService alloc] init];
//    
//    //设置代理
//    self.service.delegate = self;
//    
//    //开启定位
//    [self.service startUserLocationService];

    [self rac];
    [self startRefreshTimer];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.locationManager startUpdatingLocation];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)rac{
    [[self.satelliteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //        @strongify(self);
        self.mapView.mapType = (self.mapView.mapType == MKMapTypeStandard)?MKMapTypeSatellite:MKMapTypeStandard;
//        self.mapView.buildingsEnabled = NO;
//        self.mapView.overlooking = 0;
        self.satelliteButton.selected = (self.mapView.mapType == MKMapTypeStandard)?NO:YES;
        self.buildingsButton.selected = NO;
    }];
   
    
    
//    [[self.buildingsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        self.mapView.mapType = BMKMapTypeStandard;
//        self.mapView.buildingsEnabled = !self.mapView.buildingsEnabled;
//        self.mapView.overlooking = self.mapView.buildingsEnabled?-25:0;
//        self.buildingsButton.selected = self.mapView.buildingsEnabled?YES:NO;        self.satelliteButton.selected = NO;
//    }];
    
    [[self.zoomInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self zoomIn];
    }];
    
    [[self.zoomOutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self zoomOut];
    }];
    [[self.preButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        
    }];
    
    [[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    
}
- (void)zoomIn{
    if(self.mapView.zoomLevel >=19) return;
    self.mapView.zoomLevel++;
}
- (void)zoomOut{
    if(self.mapView.zoomLevel <=3) return;
    self.mapView.zoomLevel--;
}
- (void)startRefreshTimer{
    [self stopRefreshTimer];
    
    NSTimeInterval time = 30;
    
    if(countDownTimer == nil){
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        countdownTime = time;
        self.countDownTimeLabel.text = [NSString stringWithFormat:@"%ld", (long)countdownTime];
    }
}
- (void)stopRefreshTimer{
    [countDownTimer invalidate];
    countDownTimer = nil;
}

- (void)addSubViews{
    [self.view addSubview:self.zoomInButton];
    [self.view addSubview:self.zoomOutButton];
    [self.view addSubview:self.satelliteButton];
    [self.view addSubview:self.buildingsButton];
    [self.view addSubview:self.preButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.countDownTimeLabel];
    [self.view addSubview:self.markInfoView];
    [self.markInfoView show];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 0;
    frame.size.height = frame.size.height - self.tabBarController.tabBar.frame.size.height;
    self.mapView.frame = frame;
    
    CGFloat rightGap = 7;
    CGFloat buttonLRGap = 10;
    
    frame.size = CGSizeMake(35, 35);
    frame.origin.y = 13 + 54;
    frame.origin.x = self.view.bounds.size.width - rightGap - frame.size.width;
    self.buildingsButton.frame = frame;
    
    frame.origin.x = self.buildingsButton.frame.origin.x - buttonLRGap - frame.size.width;
    self.satelliteButton.frame = frame;
    
    frame.size.height = 35;
    frame.size.width = 35;
    frame.origin.x = self.view.frame.size.width - frame.size.width - rightGap;
    frame.origin.y = CGRectGetMaxY(self.satelliteButton.frame) + 15;
    self.zoomInButton.frame = frame;
    
    frame.origin.y = CGRectGetMaxY(frame) + 5;
    self.zoomOutButton.frame = frame;
    
    frame.origin.x = 5;
    frame.origin.y = 5 + 54;
    frame.size.height = 20;
    frame.size.width = 40;
    self.countDownTimeLabel.frame = frame;
    
    frame.size.height = 85;
    frame.size.width = 35;
    frame.origin.y = (self.view.bounds.size.height - frame.size.height)/2 - 25;
    frame.origin.x = 0;
    self.preButton.frame = frame;
    
    frame.origin.x = self.view.bounds.size.width - frame.size.width;
    self.nextButton.frame = frame;
}
- (void)countDown {
    NSTimeInterval time = 30;
    
    countdownTime--;
    if(countdownTime <= 0) {
        countdownTime = time;
//        [self.viewModel getDevicesList];
    }
    self.countDownTimeLabel.text = [NSString stringWithFormat:@"%ld", (long)countdownTime];
}

#pragma mark - Setters
- (UIButton*)zoomInButton {
    if(_zoomInButton == nil){
        _zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zoomInButton.backgroundColor = [self buttonBKColor];
        [_zoomInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_zoomInButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_zoomInButton setTitle:@"+" forState:UIControlStateNormal];
        _zoomInButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _zoomInButton.layer.cornerRadius = 6;
        _zoomInButton.layer.masksToBounds = YES;
    }
    return _zoomInButton;
}

- (UIButton*)zoomOutButton{
    if(_zoomOutButton == nil){
        _zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zoomOutButton.backgroundColor = [self buttonBKColor];
        [_zoomOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_zoomOutButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_zoomOutButton setTitle:@"-" forState:UIControlStateNormal];
        _zoomOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _zoomOutButton.layer.cornerRadius = 6;
        _zoomOutButton.layer.masksToBounds = YES;
    }
    return _zoomOutButton;
}

- (UIButton*)preButton {
    if(_preButton == nil) {
        _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preButton.backgroundColor = [UIColor clearColor];
        [_preButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    }
    return _preButton;
}

- (UIButton*)nextButton {
    if(_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [UIColor clearColor];
        [_nextButton setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    }
    return _nextButton;
}

- (UIButton*)satelliteButton{
    if(_satelliteButton == nil){
        _satelliteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _satelliteButton.backgroundColor = [self buttonBKColor];
        [_satelliteButton setBackgroundImage:[UIImage imageNamed:@"satelliteNormal"] forState:UIControlStateNormal];
        [_satelliteButton setBackgroundImage:[UIImage imageNamed:@"satelliteHeightLight"] forState:UIControlStateSelected];
        _satelliteButton.layer.cornerRadius = 6;
        _satelliteButton.layer.masksToBounds = YES;
    }
    return _satelliteButton;
}

- (UIButton*)buildingsButton{
    if(_buildingsButton == nil){
        _buildingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buildingsButton.backgroundColor = [self buttonBKColor];
        [_buildingsButton setBackgroundImage:[UIImage imageNamed:@"3DbuildingNormal"] forState:UIControlStateNormal];
        [_buildingsButton setBackgroundImage:[UIImage imageNamed:@"3DbuildingHeightLight"] forState:UIControlStateSelected];
        _buildingsButton.layer.cornerRadius = 6;
        _buildingsButton.layer.masksToBounds = YES;
    }
    return _buildingsButton;
}

- (UILabel*)countDownTimeLabel {
    if(_countDownTimeLabel == nil) {
        _countDownTimeLabel = [[UILabel alloc] init];
        _countDownTimeLabel.backgroundColor = [UIColor colorWithRed:0.27 green:0.66 blue:0.85 alpha:0.85];
        _countDownTimeLabel.textColor = [UIColor whiteColor];
        _countDownTimeLabel.font = [UIFont systemFontOfSize:12];
        _countDownTimeLabel.textAlignment = NSTextAlignmentCenter;
        _countDownTimeLabel.layer.cornerRadius = 7;
        _countDownTimeLabel.layer.masksToBounds = YES;
    }
    return _countDownTimeLabel;
}

- (MarkerInfoView*)markInfoView {
    if(_markInfoView == nil) {
        _markInfoView = [[MarkerInfoView alloc] init];
        _markInfoView.tabHeight = 0;
        _markInfoView.needBtn = YES;
        _markInfoView.delegate = self;
    }
    return _markInfoView;
}
- (UIImage *)imageAddToMark:(UIImage *)image MarkImage:(NSString*)markImage{
    
    UIImageView *markImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:markImage]];
    
    if(image != nil) {
        UIImageView *circleHeadImageView = [[UIImageView alloc] init];
        circleHeadImageView.image = image;
        circleHeadImageView.frame = CGRectMake(14, 5, 36, 36);
        circleHeadImageView.layer.cornerRadius = circleHeadImageView.frame.size.height/2;
        circleHeadImageView.layer.masksToBounds = YES;
        [markImageView addSubview:circleHeadImageView];
    }
    
    UIGraphicsBeginImageContext(markImageView.bounds.size);
    [markImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (UIColor*)buttonBKColor{
    return [UIColor colorWithWhite:0.4 alpha:0.75];
}

- (void)setZoomInOutEnable{
    CGFloat zoomLevel = 0;
    BOOL zoomInEnable = NO;
    BOOL zoomOutEnable = NO;
//    zoomInEnable = zoomLevel < self.mapView.maxZoomLevel;
//    zoomOutEnable = zoomLevel > self.mapView.minZoomLevel;
    self.zoomInButton.enabled = zoomInEnable;
    self.zoomInButton.alpha = self.zoomInButton.enabled?1:0.5;
    self.zoomOutButton.enabled = zoomOutEnable;
    self.zoomOutButton.alpha = self.zoomOutButton.enabled?1:0.5;
}
#pragma mark MarkerInfoViewDelegate
- (void)markerInfoViewBtn1Pressed:(MarkerInfoView*)markInfoView {
    YGDeviceDetailVC *deviceDetailVC = [[YGDeviceDetailVC alloc] init];
    [self presentViewController:deviceDetailVC animated:YES completion:nil];
//    deviceDetailViewController *ctrl = [[deviceDetailViewController alloc] init];
//    ctrl.title = self.viewModel.currentDeviceName;
//    ctrl.deviceID = self.viewModel.currentDeviceID;
//    ctrl.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)markerInfoViewBtn2Pressed:(MarkerInfoView*)markInfoView {
    deviceTrackViewController *ctrl = [[deviceTrackViewController alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
//    ctrl.title = self.viewModel.currentDeviceName;
//    ctrl.deviceID = self.viewModel.currentDeviceID;
//    ctrl.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (void)markerInfoViewBtn3Pressed:(MarkerInfoView*)markInfoView {
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        
        NSLog(@"只安装的高德地图触发了");
        NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",_currentLocation.coordinate.latitude,_currentLocation.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
    }
}

- (void)markerInfoViewBtn4Pressed:(MarkerInfoView*)markInfoView {
//    YGDeviceTraceVC *deviceTrackVC = [[YGDeviceTraceVC alloc] init];
//    [self presentViewController:deviceTrackVC animated:YES completion:nil];
}
- (void)markerInfoViewBtn5Pressed:(MarkerInfoView*)markInfoView {
    CLLocationCoordinate2D c = [self BD09FromGCJ02:_currentLocation.coordinate];
    NSString *title = @"设备名";
    [self showPanoramaWithCoordinate:c title:title];

}

- (void)showPanoramaWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title{
    panoramaView  *panorama = [[panoramaView alloc] initWithFrame:self.view.bounds];
    [panorama setCoordinate:coordinate title:title];
    [self.view addSubview:panorama];
}
- (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}
- (CLLocation *)AMapLocationFromBaiduLocation:(CLLocation *)BaiduLocation;
{
    const double x_pi = M_PI * 3000.0 / 180.0;
    double x = BaiduLocation.coordinate.longitude - 0.0065, y = BaiduLocation.coordinate.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double AMapLongitude = z * cos(theta);
    double AMapLatitude = z * sin(theta);
    CLLocation *AMapLocation = [[CLLocation alloc] initWithLatitude:AMapLatitude longitude:AMapLongitude];
    return AMapLocation;
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    _currentLocation = location;
    //获取到定位信息，更新annotation
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        
        [self.mapView addAnnotation:self.pointAnnotaiton];
    }
    [self.pointAnnotaiton setCoordinate:location.coordinate];
    [self.mapView setCenterCoordinate:location.coordinate];
//    [self.mapView setZoomLevel:15.1 animated:NO];

}


#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.mapView setDelegate:self];
        [self.mapView setZoomLevel:15 animated:NO];
//                self.mapView.showsUserLocation = YES;
//                self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.view addSubview:self.mapView];
    }
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        CGRect r = CGRectMake(0, 0, 20, 20);
        annotationView.frame = r;
        annotationView.canShowCallout   = NO;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.image            = [UIImage imageNamed:@"deviceMark"];
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    [self.markInfoView show];
}
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [self.markInfoView hiden];
}
@end
