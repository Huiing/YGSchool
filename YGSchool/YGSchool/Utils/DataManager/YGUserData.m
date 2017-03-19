//
//  YGUserData.m
//  YGSchool
//
//  Created by faith on 17/3/3.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGUserData.h"
#import "YGTools.h"
static YGUserData* _instance = nil;

@implementation YGUserData
#pragma mark - getters and setters
- (YGUserData *)initWithDictionary:(NSDictionary *)dic{
    self.login = dic[@"login"];
    self.accountID = dic[@"account_id"];
    self.schoolID = dic[@"school_id"];
    self.userName = dic[@"user_name"];
    self.phone = dic[@"phone"];
    self.name = dic[@"name"];
    self.headIcon = dic[@"head_icon"];
    self.passWord = dic[@"password"];
    self.userType = [dic[@"user_type"] stringValue];
    return self;
}
- (void)refreshUserData{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self userCacheFilePath]];
    _userName = dic[@"user_name"];
    _login = dic[@"login"];
}
- (void)writeDataToLocalWithDictionaryWithDic:(NSMutableDictionary *)dic{
    [dic writeToFile:[self userCacheFilePath] atomically:YES];
}
#pragma mark - private methods
- (NSString*)userFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    NSString *userFilePath = [plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", @"userData"]];
    BOOL isDirectory = NO;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:userFilePath isDirectory:&isDirectory];
    
    if(!isExists && !isDirectory){
        [[NSFileManager defaultManager] createDirectoryAtPath:userFilePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return userFilePath;
}
- (NSString*)userCacheFilePath {
    NSString *userPath = [self userFilePath];
    NSString *userCachePath = [userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_userName]];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:userCachePath];
    if(!isExists){
        [[NSFileManager defaultManager] createFileAtPath:userCachePath contents:nil attributes:nil];
    }
    return userCachePath;
}

@end
