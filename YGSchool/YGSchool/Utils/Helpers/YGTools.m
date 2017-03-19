//
//  YGTools.m
//  YGSchool
//
//  Created by faith on 17/2/25.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGTools.h"

@implementation YGTools
//userdefault
void setUserDefault(id obj ,NSString *key){
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    [userDefaults synchronize];
}

id getUserDefault(NSString *key){
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (NSString *)convertToJsonString:(NSDictionary *)dict{

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;

}

@end
