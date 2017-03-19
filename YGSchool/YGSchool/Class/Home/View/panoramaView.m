//
//  panoramaView.m
//  YLDGPS
//
//  Created by user on 15/7/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "panoramaView.h"

@interface panoramaView ()<BaiduPanoramaViewDelegate>
@property (nonatomic, strong) UIButton                         *closeButton;
@property (nonatomic, strong) UILabel                          *titleLable;
@property (nonatomic, strong) NSString                         *title;
@property (nonatomic, strong, readonly) BaiduPanoramaView      *baiduPanoramaView;

@end

@implementation panoramaView
@synthesize baiduPanoramaView =     _baiduPanoramaView;

#pragma mark - public methods
- (void)setCoordinate:(CLLocationCoordinate2D)coor title:(NSString*)title {
    
    [self.baiduPanoramaView setPanoramaAccessKey:kBaiduKey];
    [self.baiduPanoramaView setPanoramaWithLon:coor.longitude lat:coor.latitude];
    
    self.titleLable.text = title;
}

#pragma mark - life cyle
- (void)dealloc{
    
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self addSubview:self.baiduPanoramaView];

    [self addSubview:self.closeButton];
    [self addSubview:self.titleLable];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    
    self.baiduPanoramaView.frame = frame;

    
    frame.origin.x = 9;
    frame.origin.y = 9;
    frame.size.height = 35;
    frame.size.width = 35;
    self.closeButton.frame = frame;
    
    frame.size.height = self.titleLable.font.lineHeight;
    frame.origin.x = CGRectGetMaxX(frame) + 10;
    frame.size.width = self.frame.size.width - frame.origin.x*2;
    self.titleLable.frame = frame;

}

#pragma mark - BaiduPanoramaViewDelegate
- (void)panoramaLoadFailed:(BaiduPanoramaView *)panoramaView error:(NSError *)error{
    if(error != nil) {
        [self alertErrorMsg:error.localizedDescription];
    }
}

- (void)panoramaDidLoad:(BaiduPanoramaView *)panoramaView descreption:(NSString *)jsonStr {
    
//    NSData *data =[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    
//    NSInteger x = [dic[@"X"] integerValue];
//    NSInteger Y = [dic[@"Y"] integerValue];
//    
//    [panoramaView setPanoramaWithX:x Y:Y];

    [panoramaView setPanoramaAccessKey:kBaiduKey];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.closeButton.enabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }
     ];
}

#pragma mark - private methods
- (void)alertErrorMsg:(NSString*)msg {
    msg = @"暂无街景提供，请稍后再试。";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}


#pragma mark - getters and setters
- (BaiduPanoramaView*)baiduPanoramaView{

    if(_baiduPanoramaView == nil){
        _baiduPanoramaView = [[BaiduPanoramaView alloc] initWithFrame:self.bounds key:kBaiduKey];
        [_baiduPanoramaView setPanoramaImageLevel:ImageDefinitionMiddle];
        _baiduPanoramaView.delegate = self;
    }
    return _baiduPanoramaView;
}

- (UIButton*)closeButton{
    if(_closeButton == nil){
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.7];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 5;
        @weakify(self);
        [[_closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            self.closeButton.enabled = NO;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }
             ];
            
        }];
    }
    return _closeButton;
}

- (UILabel*)titleLable {
    if(_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:13];
        _titleLable.textColor = [UIColor darkTextColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

@end
