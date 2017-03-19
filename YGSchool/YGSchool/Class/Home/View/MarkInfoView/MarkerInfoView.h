//
//  MarkerInfoView.h
//  YLDGPS
//
//  Created by user on 15/12/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarkerInfoViewDelegate;

@interface MarkerInfoView : UIView
@property (nonatomic, assign) id<MarkerInfoViewDelegate>    delegate;
@property (nonatomic, copy) NSString                        *title;
@property (nonatomic, copy) NSString                        *subTitle;
@property (nonatomic, copy) NSString                        *subTitle1;
@property (nonatomic, copy) NSString                        *btnTitle1;
@property (nonatomic, copy) NSString                        *btnTitle2;
@property (nonatomic, copy) NSString                        *btnTitle3;
@property (nonatomic, copy) NSString                        *btnTitle4;
@property (nonatomic, copy) NSString                        *btnTitle5;

@property (nonatomic, assign) BOOL                          isLoadingAddress;
@property (nonatomic, assign) CGFloat                       tabHeight;
@property (nonatomic, assign) BOOL                          needBtn;

- (void)show;
- (void)hiden;
@end

@protocol MarkerInfoViewDelegate <NSObject>
@optional
- (void)markerInfoViewBtn1Pressed:(MarkerInfoView*)markInfoView;
- (void)markerInfoViewBtn2Pressed:(MarkerInfoView*)markInfoView;
- (void)markerInfoViewBtn3Pressed:(MarkerInfoView*)markInfoView;
- (void)markerInfoViewBtn4Pressed:(MarkerInfoView*)markInfoView;
- (void)markerInfoViewBtn5Pressed:(MarkerInfoView*)markInfoView;
@end