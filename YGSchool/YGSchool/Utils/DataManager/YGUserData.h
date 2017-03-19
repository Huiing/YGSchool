//
//  YGUserData.h
//  YGSchool
//
//  Created by faith on 17/3/3.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UserType) {
    UserTypeTeacher,
    UserTypeParent,
};

@interface YGUserData : NSObject
@property (nonatomic, copy) NSString                                *userName;
@property (nonatomic, copy) NSString                                *phone;
@property (nonatomic, copy) NSString                                *name;
@property (nonatomic, copy) NSString                                *passWord;
@property (nonatomic, copy) NSString                                *accountID;
@property (nonatomic, copy) NSString                                *schoolID;
@property (nonatomic, copy) NSString                                *headIcon;
@property (nonatomic, assign) NSString *userType;
@property (nonatomic, copy) NSString                                *pushId;
@property (nonatomic, copy) NSString  *login;

//@property (nonatomic, copy) NSString                                *headIcon;
- (YGUserData *)initWithDictionary:(NSDictionary *)dic;
@end
