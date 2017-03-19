//
//  YGLDataManager.m
//  YGSchool
//
//  Created by faith on 17/3/3.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGLDataManager.h"
static YGLDataManager* _instance = nil;
@implementation YGLDataManager
+(instancetype)manager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[YGLDataManager alloc] init];
    }) ;
    return _instance ;
}
- (void)writeDataToLocalWithDictionaryWithDic:(NSMutableDictionary *)dic{
    [dic writeToFile:[self userCacheFilePath] atomically:YES];
}
//- (void)getUserData{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[self userCacheFilePath]];
//    if(!dic){
//        dic = [NSMutableDictionary dictionary];
//        [dic setObject:[NSNumber numberWithBool:NO] forKey:@"login"];
//        self.userData.login = [dic[@"login"] boolValue];
//        [dic writeToFile:[self userCacheFilePath] atomically:YES];
//    }
//    self.userData.login = [dic[@"login"] boolValue];
//    self.userData.userName = dic[@"username"];
//}
- (YGUserData *)userData{
    if(!_userData){
        _userData = [[YGUserData alloc] init];
        
    }
    return _userData;
}
#pragma mark - private methods
- (NSString*)userFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSLog(@"plistPath:%@",plistPath);
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
    NSString *userCachePath = [userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"account"]];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:userCachePath];
    if(!isExists){
        [[NSFileManager defaultManager] createFileAtPath:userCachePath contents:nil attributes:nil];
    }
    return userCachePath;
}


@end
