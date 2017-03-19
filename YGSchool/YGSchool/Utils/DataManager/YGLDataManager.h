//
//  YGLDataManager.h
//  YGSchool
//
//  Created by faith on 17/3/3.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGUserData.h"
typedef NS_ENUM(NSInteger, NetStatusType) {
    NetStatusTypeNO,
    NetStatusTypeWWAN,
    NetStatusTypeWiFi,
};
@interface YGLDataManager : NSObject
@property (nonatomic, strong) YGUserData  *userData;
@property (nonatomic, assign) NetStatusType netStatusType;
+(instancetype)manager;
- (NSString*)userFilePath;
- (NSString*)userCacheFilePath;
- (void)getUserData;
@end
