//
//  YGSegmentItem.m
//  YGSchool
//
//  Created by faith on 17/2/20.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGSegmentItem.h"
@interface YGSegmentItem()
@property(nonatomic, strong) CALayer  *contentLayer;

@end
@implementation YGSegmentItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLayer = [[CALayer alloc] init];
        self.contentLayer.backgroundColor = self.backgroundColor.CGColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if ([YGSegmentItem isStringEmpty:self.title]) {
        return;
    }
    UIColor *titleColor = self.selected? self.highlightColor: self.titleColor;
    CGFloat x = (CGRectGetWidth(rect) - [YGSegmentItem caculateTextWidth:self.title withFont:self.titleFont])/2;
    CGFloat y = (CGRectGetHeight(self.frame) - self.titleFont.pointSize)/2;
    [self.title drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName: self.titleFont, NSForegroundColorAttributeName: titleColor}];
}

+ (CGFloat)caculateWidthWithtitle:(NSString *)title titleFont:(UIFont *)titleFont
{
    CGFloat width = Item_Padding * 2 + [YGSegmentItem caculateTextWidth:title withFont:titleFont];
    
    return width;
}

- (void)refresh
{
    [self setNeedsDisplay];
}

+ (BOOL)isStringEmpty:(NSString *)text
{
    if (!text || [text isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (CGFloat)caculateTextWidth:(NSString *)text withFont:(UIFont *)font
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([YGSegmentItem isStringEmpty:text]) {
        return 0;
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGRect newRect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    text = nil;
    return newRect.size.width;
}

@end
