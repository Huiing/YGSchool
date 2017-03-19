//
//  YGNetWorkManager.m
//  YGSchool
//
//  Created by faith on 17/2/14.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGNetWorkManager.h"
#import "YGCommon.h"
#import "YGApiConfig.h"
@implementation YGNetWorkManager

#pragma mark - get请求方式获取数据
+ (void)getNetWorkRequestUrlString:(NSString *)urlString
                            params:(id)params success:(Completion)success
                              fail:(FailError)fail;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self manager:manager];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息:%@",error);
        if (fail) {
            fail();
        }
    }];
}
//网络请求头部参数
+ (void)manager:(AFHTTPSessionManager *)manager
{
    //设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    NSSet *set = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    //设置返回格式
    AFJSONResponseSerializer *responseSerializer =[AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES;
    manager.responseSerializer = responseSerializer;
}


#pragma mark - post请求方式获取数据
+ (void)getDataWithURL:(NSString *)url postData:(id)parameters withHeader:(NSString *)header success:(Completion)success
                   fail:(FailError)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (header == nil) {
    }else{
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)[task response];
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200) {
            // NSLog(@"data is %@",responseObject);
            if(success != nil) {
                success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
            }
        }else{
            if(success!=nil) {
                success(responseObject);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(
            );
        }
    }];
}

#pragma mark - post请求方式获取数据
+ (void)postDataWithURL:(NSString *)url postData:(id)parameters withHeader:(NSString *)header success:(Completion)success
                     fail:(FailError)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (header == nil) {
    }else{
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)[task response];
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200) {
            // NSLog(@"data is %@",responseObject);
            if(success != nil) {
                success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
            }
        }else{
            if(success!=nil) {
                success(responseObject);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(
            );
        }
    }];
}

//注册
+ (void)registerWithParameter:(NSMutableDictionary *)parameter
                   completion:(Completion)completion
                         fail:(FailError)fail{
    [self postDataWithURL:URL_Register postData:parameter withHeader:nil success:completion fail:fail];
}
//登录
+ (void)loginWithParameter:(NSMutableDictionary *)parameter
                completion:(Completion)completion
                      fail:(FailError)fail{
    [self postDataWithURL:URL_Login postData:parameter withHeader:nil success:completion fail:fail];
}
//学生列表
+ (void)getStudentListWithParameter:(NSMutableDictionary *)parameter
                         completion:(Completion)completion
                               fail:(FailError)fail{
    [self postDataWithURL:URL_StudentList postData:parameter withHeader:nil success:completion fail:fail];
    
}

//学校列表
+ (void)getSchoolListWithParameter:(id)               parameter completion:(Completion)completion
                              fail:(FailError)fail{
    [self postDataWithURL:URL_SchoolList postData:parameter withHeader:nil success:completion fail:fail];
}
//班级列表
+ (void)getClassListWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                             fail:(FailError)fail{
    [self postDataWithURL:URL_ClassList postData:parameter withHeader:nil success:completion fail:fail];
}
//布置作业(老师端)
+ (void)addHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail{
    [self postDataWithURL:URL_AddHomework postData:parameter withHeader:nil success:completion fail:fail];
}
//编辑作业(老师端)
+ (void)editHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                             fail:(FailError)fail{
    [self postDataWithURL:URL_EditHomework postData:parameter withHeader:nil success:completion fail:fail];
}
//审核作业(家长端)
+ (void)verifyHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                               fail:(FailError)fail{
    [parameter setObject:@"homeworkAdult" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"student_id"];
    [parameter setObject:@"" forKey:@"homework_id"];

}

//上传作业附件(老师端)
+ (void)uploadAttachmentWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                 fail:(FailError)fail{
    [parameter setObject:@"homeworkUpload" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"file"];
}
//查询作业
+ (void)queryHomeworkWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail{
    [self postDataWithURL:URL_QueryHomework postData:parameter withHeader:nil success:completion fail:fail];
}
//删除作业
+ (void)delectHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                               fail:(FailError)fail{
    [self postDataWithURL:URL_DelectHomework postData:parameter withHeader:nil success:completion fail:fail];
}
//成绩查询
+ (void)queryScoreWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_QueryCourse postData:parameter withHeader:nil success:completion fail:fail];
}
//课程列表查询
+ (void)queryCourseWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion fail:(FailError)fail{
    [self postDataWithURL:URL_QueryScore postData:parameter withHeader:nil success:completion fail:fail];

}
//请假单添加
+ (void)addLeaveWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion fail:(FailError)fail{
    [self postDataWithURL:URL_AddLeaveBill postData:parameter withHeader:nil success:completion fail:fail];

}
//请假单编辑
+ (void)editLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                         fail:(FailError)fail{
    [self postDataWithURL:URL_EditLeaveBill postData:parameter withHeader:nil success:completion fail:fail];
    
}

//请假单删除
+ (void)delectLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                            fail:(FailError)fail{
    [self postDataWithURL:URL_DelectLeaveBill postData:parameter withHeader:nil success:completion fail:fail];
}
//请假单审核
+ (void)verifyLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                            fail:(FailError)fail{
    [self postDataWithURL:URL_DelectLeaveBill postData:parameter withHeader:nil success:completion fail:fail];
}
//请假单列表查询
+ (void)queryLeaveWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_QueryLeaveBill postData:parameter withHeader:nil success:completion fail:fail];
}
//公告列表查询
+ (void)querynoticelistWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail{
    [self postDataWithURL:URL_QueryNoticeList postData:parameter withHeader:nil success:completion fail:fail];

}
//审核列表查询
+ (void)queryverifylistWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail{
    [parameter setObject:@"" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
}
//审核
+ (void)verifyWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                       fail:(FailError)fail{
    [parameter setObject:@"" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];

}
//奖励列表查询
+ (void)queryRewardListWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail{
    [self postDataWithURL:URL_QueryRewardList postData:parameter withHeader:nil success:completion fail:fail];
}
//惩罚列表查询
+ (void)querypunishmentListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion fail:(FailError)fail{
    [self postDataWithURL:URL_PunishmentList postData:parameter withHeader:nil success:completion fail:fail];
}
//相册列表查询
+ (void)queryAlbumListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                               fail:(FailError)fail{
    [self postDataWithURL:URL_QueryAlbum postData:parameter withHeader:nil success:completion fail:fail];
}
//相册创建
+ (void)setUpAlbumWithParameter:(NSMutableDictionary *)parameter
                     completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_SetUpAlbum postData:parameter withHeader:nil success:completion fail:fail];
}
//相册编辑
+ (void)editAlbumWithParameter:(NSMutableDictionary *)parameter
                    completion:(Completion)completion
                          fail:(FailError)fail{
    [self postDataWithURL:URL_EditAlbum postData:parameter withHeader:nil success:completion fail:fail];
}
//相册删除
+ (void)delectAlbumWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                            fail:(FailError)fail{
    [self postDataWithURL:URL_DelectAlbum postData:parameter withHeader:nil success:completion fail:fail];
}
//上传图片
+ (void)uploadProfileWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail{
    [parameter setObject:@"" forKey:@"event_code"];
    [parameter setObject:@"" forKey:@"account_id"];
    [parameter setObject:@"" forKey:@"head_icon"];
}
//绑定微信
+ (void)bindwechatWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_BindWeChat postData:parameter withHeader:nil success:completion fail:fail];
}
//班级课程表查询
+ (void)queryScheduleWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail{
    
}
//添加学生(家长端)
+ (void)addStudentWithParameter:(NSMutableDictionary *)parameter
                     completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_AddStudent postData:parameter withHeader:nil success:completion fail:fail];
}
//解绑学生(家长端)
+ (void)unBindStudentWithParameter:(NSMutableDictionary *)parameter
                        completion:(Completion)completion
                              fail:(FailError)fail{
     [self postDataWithURL:URL_UnBindStudent postData:parameter withHeader:nil success:completion fail:fail];
}
//添加学生审核(老师端)
+ (void)addStudentVerifyWithParameter:(NSMutableDictionary *)parameter
                           completion:(Completion)completion
                                 fail:(FailError)fail{
    [self postDataWithURL:URL_AddStudentVerify postData:parameter withHeader:nil success:completion fail:fail];
}
//修改密码
+ (void)changPasswordWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail{
    [self postDataWithURL:URL_ChangePassword postData:parameter withHeader:nil success:completion fail:fail];
}
//修改用户信息
+ (void)changUserInforWithParameter:(NSMutableDictionary *)parameter
                         completion:(Completion)completion
                               fail:(FailError)fail{
    [self postDataWithURL:URL_ChangeUserInfor postData:parameter withHeader:nil success:completion fail:fail];
}
//上传APP用户头像
+ (void)upLoadUserProfileWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                  fail:(FailError)fail{
    [self postDataWithURL:URL_UpLoadUserProfile postData:parameter withHeader:nil success:completion fail:fail];
}
// 发送短信验证码
+ (void)sendVerifyCodeWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                               fail:(FailError)fail{
    [self postDataWithURL:URL_SendVerifyCode postData:parameter withHeader:nil success:completion fail:fail];
}
// 验证短信验证码
+ (void)verifyCodeWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                           fail:(FailError)fail{
    [self postDataWithURL:URL_verifyCode postData:parameter withHeader:nil success:completion fail:fail];
}
//获取AppStore上的版本号
+(void)getAppVersionWithCompletion:(Completion)completion
                              fail:(FailError)fail{
    [self getNetWorkRequestUrlString:URL_AppAddress params:nil success:completion fail:fail];
}
//我的学生列表
+ (void)getMyStudentListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                 fail:(FailError)fail{
    [self postDataWithURL:URL_MyStudentList postData:parameter withHeader:nil success:completion fail:fail];
    
}
//获取学科列表
+ (void)getObjectListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail{
    [self postDataWithURL:URL_ObjectList postData:parameter withHeader:nil success:completion fail:fail];
    
}
@end
