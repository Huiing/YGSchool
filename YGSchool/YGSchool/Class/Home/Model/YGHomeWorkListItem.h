//
//  YGHomeWorkListItem.h
//  YGSchool
//
//  Created by faith on 17/2/17.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGHomeWorkListItem : NSObject
@property(nonatomic, strong)NSString *homeworkId;
@property(nonatomic, strong)NSString *classId;
@property(nonatomic, strong)NSString *className;
@property(nonatomic, strong)NSArray *date;
@property(nonatomic, strong)NSString *course;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSArray *imgs;
@end
