//
//  ExtenButton.m
//  YLDGPS
//
//  Created by user on 16/4/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ExtenButton.h"

@implementation LTextRImageBtn
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect frame = CGRectZero;
    frame.origin.x = 2;
    frame.origin.y = 2;
    frame.size.height = contentRect.size.height - frame.origin.y*2;
    frame.size.width = contentRect.size.width/10*6 - 2*2;
    return frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect frame = CGRectZero;
    frame.origin.y = 3;
    frame.size.height = contentRect.size.height - frame.origin.y*2;
    frame.size.width = frame.size.height;
    frame.origin.x = contentRect.size.width/10*6 + 2;
    return frame;
}
@end

@implementation TImageBTitleBtn
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect frame = CGRectZero;
    frame.origin.y = contentRect.size.height/10*6 + 2;
    frame.origin.x = 2;
    frame.size.height = contentRect.size.height/10*3 - 4;
    frame.size.width = contentRect.size.width - frame.origin.x*2;
    return frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect frame = CGRectZero;
    frame.origin.y = 0;
    frame.size.height = contentRect.size.height/10*6 - frame.origin.y*2;
    frame.size.width = frame.size.height;
    frame.origin.x = (contentRect.size.width - frame.size.width)/2;
    return frame;
}
@end