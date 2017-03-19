//
//  AppDelegate.m
//  YGSchool
//
//  Created by faith on 17/2/14.
//  Copyright © 2017年 YDK. All rights reserved.


#import "YGAppDelegate.h"
#import "YGShow.h"
#import "YGCommon.h"
@interface YGAppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation YGAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = @"7d210008022d34dc56afa9a9b6e8f814";
    // shareSDK短信验证码
    [SMSSDK registerApp:@"1befc241654bb"
        withSecret:@"fc762240da11e4a0c1d1d48f79552839"];
    // 极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    NSString *pushID = [JPUSHService registrationID];
    NSLog(@"push:%@",pushID);
    [YGLDataManager manager].userData.pushId = pushID;
//    [[YGLDataManager manager] getUserData];
    [self rac];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setRootCtrl];
    return YES;
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger)
                                                               )completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
        ]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执 这个 法,选择 是否提醒 户,有Badge、Sound、Alert三种类型可以选择设置
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)
                                                                          ())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(); // 系统要求执 这个 法
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
        // Required, iOS 7 Support
        [JPUSHService handleRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        // Required,For systems with less than or equal to iOS6
        [JPUSHService handleRemoteNotification:userInfo];
}
#pragma mark - private methods
- (void)netWorkStatus{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NetStatusType netstatus;;
        if(status == AFNetworkReachabilityStatusNotReachable){
            netstatus = NetStatusTypeNO;
        }else if(status == AFNetworkReachabilityStatusReachableViaWWAN){
            netstatus = NetStatusTypeWWAN;
        }else if(status == AFNetworkReachabilityStatusReachableViaWiFi){
            netstatus = NetStatusTypeWiFi;
        }
        [YGLDataManager manager].netStatusType = netstatus;
        NSLog(@"netstatus:%ld", (long)netstatus);
        //[TSMessage showNotificationWithTitle:netstatus type:TSMessageNotificationTypeMessage];
    }];
}

- (void)rac{
    @weakify(self);
    [[RACObserve([YGLDataManager manager].userData, login) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self setRootCtrl];
    }];
}
- (void)setRootCtrl{
    NSString *path = [[YGLDataManager manager] userCacheFilePath];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [YGLDataManager manager].userData = [[YGUserData alloc] initWithDictionary:dic];
    if(!path || [dic[@"login"] integerValue] ==0){
        [YGShow toLogin];
    }else{
        [YGShow showRootViewController];

    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
