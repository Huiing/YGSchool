//
//  YGNetWorkManager.h
//  YGSchool
//
//  Created by faith on 17/2/14.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Completion)(id responseObject);
typedef void(^FailError)();
typedef void(^FileURL)(NSURL *fileURL);
typedef void(^CompletionHandler)(NSURLResponse *response, NSURL *filePath, NSError *error);
//定义回调函数
typedef void(^HttpCallback)(NSDictionary *json,BOOL result);
@interface YGNetWorkManager : NSObject
//注册
+ (void)registerWithParameter:(NSMutableDictionary *)parameter
                   completion:(Completion)completion
                         fail:(FailError)fail;
//登录
+ (void)loginWithParameter:(NSMutableDictionary *)parameter
                   completion:(Completion)completion
                         fail:(FailError)fail;
//学生列表
+ (void)getStudentListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                      fail:(FailError)fail;
//学校列表
+ (void)getSchoolListWithParameter:(id)               parameter completion:(Completion)completion
                               fail:(FailError)fail;
//班级列表
+ (void)getClassListWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                              fail:(FailError)fail;
//布置作业(老师端)
+ (void)addHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                              fail:(FailError)fail;
//编辑作业(老师端)
+ (void)editHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail;
//审核作业(家长端)
+ (void)verifyHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                             fail:(FailError)fail;

//上传作业附件(老师端)
+ (void)uploadAttachmentWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                               fail:(FailError)fail;

//查询作业
+ (void)queryHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                 fail:(FailError)fail;

//删除作业
+ (void)delectHomeworkWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                              fail:(FailError)fail;
//成绩查询
+ (void)queryScoreWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                               fail:(FailError)fail;
//课程列表查询
+ (void)queryCourseWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                           fail:(FailError)fail;
//请假单添加
+ (void)addLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                            fail:(FailError)fail;
//请假单编辑
+ (void)editLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                          fail:(FailError)fail;
//请假单删除
+ (void)delectLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                         fail:(FailError)fail;
//请假单审核
+ (void)verifyLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                            fail:(FailError)fail;

//请假单列表查询
+ (void)queryLeaveWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                            fail:(FailError)fail;

//公告列表查询
+ (void)querynoticelistWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                           fail:(FailError)fail;
//审核列表查询
+ (void)queryverifylistWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail;
//审核
+ (void)verifyWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                                fail:(FailError)fail;
//奖励列表查询
+ (void)queryRewardListWithParameter:(NSMutableDictionary *)               parameter completion:(Completion)completion
                       fail:(FailError)fail;
//惩罚列表查询
+ (void)querypunishmentListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                fail:(FailError)fail;
//相册列表查询
+ (void)queryAlbumListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                    fail:(FailError)fail;
//相册创建
+ (void)setUpAlbumWithParameter:(NSMutableDictionary *)parameter
                     completion:(Completion)completion
                           fail:(FailError)fail;
//相册编辑
+ (void)editAlbumWithParameter:(NSMutableDictionary *)parameter
                    completion:(Completion)completion
                          fail:(FailError)fail;
//相册删除
+ (void)delectAlbumWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                         fail:(FailError)fail;
//上传图片
+ (void)uploadProfileWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                               fail:(FailError)fail;
//绑定微信
+ (void)bindwechatWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                              fail:(FailError)fail;

//班级课程表查询
+ (void)queryScheduleWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                           fail:(FailError)fail;
//添加学生(家长端)
+ (void)addStudentWithParameter:(NSMutableDictionary *)parameter
                   completion:(Completion)completion
                         fail:(FailError)fail;
//解绑学生(家长端)
+ (void)unBindStudentWithParameter:(NSMutableDictionary *)parameter
                     completion:(Completion)completion
                           fail:(FailError)fail;
//添加学生审核(老师端)
+ (void)addStudentVerifyWithParameter:(NSMutableDictionary *)parameter
                        completion:(Completion)completion
                              fail:(FailError)fail;
//修改密码
+ (void)changPassWordWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                 fail:(FailError)fail;
//修改用户信息
+ (void)changUserInforWithParameter:(NSMutableDictionary *)parameter
                        completion:(Completion)completion
                              fail:(FailError)fail;
//上传APP用户头像
+ (void)upLoadUserProfileWithParameter:(NSMutableDictionary *)parameter
                         completion:(Completion)completion
                               fail:(FailError)fail;
//忘记密码
// 发送短信验证码
+ (void)sendVerifyCodeWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                  fail:(FailError)fail;
// 验证短信验证码
+ (void)verifyCodeWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                               fail:(FailError)fail;
//获取AppStore上的版本号
+(void)getAppVersionWithCompletion:(Completion)completion
                                  fail:(FailError)fail;
//我的学生列表
+ (void)getMyStudentListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                               fail:(FailError)fail;
//获取学科列表
+ (void)getObjectListWithParameter:(NSMutableDictionary *)parameter completion:(Completion)completion
                                 fail:(FailError)fail;

@end
