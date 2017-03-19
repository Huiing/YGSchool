//
//  YGTools.h
//  YGSchool
//
//  Created by faith on 17/2/25.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGTools : NSObject
//userdefault
void setUserDefault(id obj ,NSString *key);
id getUserDefault(NSString *key);
+ (NSString *)convertToJsonString:(NSDictionary *)dict;

#pragma mark - 将某个时间戳转化成时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
@end
