//
//  YGCommon.h
//  YGSchool
//
//  Created by faith on 17/3/1.
//  Copyright © 2017年 YDK. All rights reserved.
//

#ifndef YGCommon_h
#define YGCommon_h


#endif /* YGCommon_h */

// VC
#import "YGHomeWorkListVC.h"
#import "YGAddHomeWorkVC.h"
#import "YGHomeVC.h"
#import "YGEditHomeWorkVC.h"
#import "YGSignListVC.h"
#import "YGAttendanceVC.h"
#import "YGScoreVC.h"
#import "YGGPSVC.h"
#import "YGLeaveVC.h"
#import "YGNoticeVC.h"
#import "YGNoticeDetailVC.h"
#import "YGVerifyDetailVC.h"
#import "YGRewardPunishmentVC.h"
#import "YGRewardPunishmentDetailVC.h"
#import "YGAlbumVC.h"
#import "YGAddAlbumVC.h"
#import "YGEditAlbumVC.h"
#import "YGSettingVC.h"
#import "YGScheduleVC.h"
#import "YGLoginVC.h"
#import "YGRegisterVC.h"
#import "YGEditInformationVC.h"
#import "YGForgetPasswordVC.h"
#import "YGChooseUserTypeVC.h"
#import "YGBindedStudentVC.h"
#import "YGUserData.h"
#import "YGLDataManager.h"
#import "deviceTrackViewController.h"
#import "YGStudentListVC.h"
#import "YGDeviceDetailVC.h"
#import "YGDeviceInfoVC.h"
#import "YGDeviceTraceVC.h"
#import "YGDeviceTrackVC.h"
#import "YGFenceVC.h"
#import "YGFenceEditVC.h"
#import "YGRemindRecevieVC.h"


//Model
#import "YGHomeWorkListItem.h"
#import "YGLeaveListItem.h"
#import "YGAlbumListItem.h"
#import "deviceTrackViewModel.h"
#import "YGScoreItem.h"

// View
#import "YGHomeItemCell.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"
#import "YGHeadDateView.h"
#import "YGHomeWorkListCell.h"
#import "YGPhotoCollectionView.h"
#import "YGSegmentItem.h"
#import "YGSegmentControl.h"
#import "YGLeaveListCell.h"
#import "YGNoticeListCell.h"
#import "YGVerifyCell.h"
#import "YGChooseControl.h"
#import "YGLeaveShadeView.h"
#import "YGAlbumListCell.h"
#import "YGBoardView.h"
#import "YGChooseUserTypeView.h"
#import "YGShadeView.h"
#import "YGAddBindShadeView.h"
#import "YGRegisterShadeView.h"
#import "YGBindedStudentCell.h"
#import "ExtenButton.h"
#import "MarkerInfoView.h"
#import "panoramaView.h"
#import "MDPieView.h"
#import "YGScoreListCell.h"
#import "YGTabbarView.h"
#import "YLDGridView.h"

//第三方库
#import <ReactiveCocoa.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AFNetworking.h>
#import "MWPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import <SMS_SDK/SMSSDK.h>


#import "JPUSHService.h"
#ifdef  NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> 
#endif

#import <FSCalendar.h>
#import "HourPickerView.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <BaiduPanoSDK/BaiduPanoramaView.h>
//keys
#define kBaiduKey @"ry8KfAOh7ivVnFMjVkWKnbIj"

//AppStore信息的地址
#define URL_AppAddress @"http://itunes.apple.com/lookup?id=1111171225"

#define IS_IOS_7 (([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7) ? YES : NO)
//根据rgb值获取颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define BG_COLOR  COLOR(46,132,196,1)
#define SeparatorLine_COLOR  COLOR_WITH_HEX(0xf2f4f5)


#define kTabbarHeight 50


#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define KMapHeight 180
#define kGirdWidth  [[UIScreen mainScreen] bounds].size.width/3
#define kGirdHeight (kScreenHeight - KMapHeight - 64)/3


//Category
#import "UIViewExt.h"
#import "NSString+utilty.h"
#import "NSObject+utilty.h"
#import "MBProgressHUD+show.h"
#import "YGShow.h"
#import "YGNetWorkManager.h"
#import "YGTools.h"




