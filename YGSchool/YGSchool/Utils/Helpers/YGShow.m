//
//  YGShow.m
//  YGSchool
//
//  Created by faith on 17/2/15.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGShow.h"
#import "YGAppDelegate.h"
#import "YGCommon.h"
@implementation YGShow
//刷新App
+(void)showRootViewController{
    YGAppDelegate *appDelegate = (YGAppDelegate *)[[UIApplication sharedApplication] delegate];
    YGHomeVC *vc = [[YGHomeVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    appDelegate.window.rootViewController = nav;
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    // set them
//    YGAppDelegate *appDelegate = (YGAppDelegate *)[[UIApplication sharedApplication] delegate];
//    //此处重新加载app rootViewController.我使用tabbar
//    UITabBarController* tabbar = [storyBoard instantiateViewControllerWithIdentifier:@"superTabBar"];
//    
//    UIViewController *home = [storyBoard instantiateViewControllerWithIdentifier:@"YGHomeNav"];
//    home.tabBarItem.title = @"主页";
//    home.tabBarItem.image = [UIImage imageNamed:@"home"];
//    home.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
//    UIViewController *rewardPunishment = [storyBoard instantiateViewControllerWithIdentifier:@"YGRewardPunishmentNav"];
//    rewardPunishment.tabBarItem.title = @"奖惩";
//    rewardPunishment.tabBarItem.image = [UIImage imageNamed:@"rewardPunishment"];
//    rewardPunishment.tabBarItem.selectedImage = [UIImage imageNamed:@"rewardPunishment_selected"];
//    UIViewController *schedule = [storyBoard instantiateViewControllerWithIdentifier:@"YGScheduleNav"];
//    schedule.tabBarItem.title = @"课表";
//    schedule.tabBarItem.image = [UIImage imageNamed:@"schedule"];
//    schedule.tabBarItem.selectedImage = [UIImage imageNamed:@"schedule_selected"];
//    UIViewController *album = [storyBoard instantiateViewControllerWithIdentifier:@"YGAlbumNav"];
//    album.tabBarItem.title = @"相册";
//    album.tabBarItem.image = [UIImage imageNamed:@"album"];
//    album.tabBarItem.selectedImage = [UIImage imageNamed:@"album_selected"];
//    UIViewController *setting = [storyBoard instantiateViewControllerWithIdentifier:@"YGSettingNav"];
//    setting.tabBarItem.title = @"设置";
//    setting.tabBarItem.image = [UIImage imageNamed:@"setting"];
//    setting.tabBarItem.selectedImage = [UIImage imageNamed:@"setting_selected"];
//    NSMutableArray *tabArrs = [NSMutableArray arrayWithArray:@[home, rewardPunishment,schedule,album,setting]];
//    tabbar.viewControllers = tabArrs;
//    
//    appDelegate.window.rootViewController = tabbar;

    
}
+ (void)toLogin{
    YGAppDelegate *appDelegate = (YGAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = [[YGLoginVC alloc] init];
}
+ (void)hideHUD{
    [MBProgressHUD hideHUD];
}
+ (void)showError:(NSString *)error{
    [YGShow hideHUD];
    [MBProgressHUD showError:error];
}


+ (void)StatusWithObj:(id )obj withStr:(NSString *)str isSuccessBlock:(isLoginBlock)isSuccessBlock isErrorBlock:(isLoginBlock)isErrorBlock{
    [YGShow hideHUD];
    NSString *type = str;
    if (type == nil || [[type Zero] length]==0) {
        type = @"^~^";
    }
    if (obj != nil) {
        NSDictionary *dic = obj;
        if([[dic objectForKey:@"code"] integerValue] == 1){
            if (isSuccessBlock != nil) {
                isSuccessBlock();
            }
        }else{
            [YGShow showError:[[dic objectForKey:@"info"] Zero]];
            if (isErrorBlock != nil) {
                isErrorBlock();
            }
        }
    }else{
        [YGShow showError:@"网络错误"];
        if (isErrorBlock != nil) {
            isErrorBlock();
        }
    }
}

#pragma mark - 补全分割线
+ (void)fullSperatorLine:(UITableView *)tableView {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
