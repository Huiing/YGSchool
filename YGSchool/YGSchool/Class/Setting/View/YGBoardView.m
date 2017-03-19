//
//  YGBoardView.m
//  YGSchool
//
//  Created by faith on 17/2/16.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGBoardView.h"
#import "YGApiConfig.h"
@implementation YGBoardView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setLineNumber:(int)lineNumber{
    _lineNumber = lineNumber;
}
- (void)setCorner:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(8, 8)]; // UIRectCornerBottomRight通过这个设置
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    
}
- (void)drawRect:(CGRect)rect {
    for(int i = 0; i < _lineNumber;i++){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, 0, 30*(i+1));
        CGContextAddLineToPoint(context, rect.size.width, 30*(i+1));
        CGContextSetLineWidth(context, 0.5);
        CGFloat components[] = {221.0/255,221.0/255,221.0/255,1.0f};
        CGContextSetStrokeColor(context, components);
        CGContextStrokePath(context);
    }
}
@end
