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
@end
