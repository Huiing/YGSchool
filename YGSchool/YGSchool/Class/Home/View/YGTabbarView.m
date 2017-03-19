//
//  YGTabbarView.m
//  YGSchool
//
//  Created by faith on 17/3/8.
//  Copyright © 2017年 YDK. All rights reserved.
//


#import "YGTabbarView.h"
#import "YGCommon.h"
#define kIndicatorHeight 3

@interface YGTabbarView ()
@property (nonatomic, strong) NSMutableArray        *items;
@property (nonatomic, strong) UIImageView           *indicatorView;
@property (nonatomic, assign) NSInteger              selectedIndex;
@end

@implementation YGTabbarView

#pragma mark - life cyle
- (void)didMoveToSuperview{
    if(self.superview != nil){
        self.userInteractionEnabled = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    frame.size.height = self.frame.size.height;
    frame.size.width = self.frame.size.width/self.items.count;
    for(UIButton *item in self.items){
        item.frame = frame;
        frame.origin.x = CGRectGetMaxX(frame);
    }
    
    frame.size.height = kIndicatorHeight;
    frame.origin.x = self.selectedIndex*frame.size.width;
    frame.origin.y = self.frame.size.height - frame.size.height;
    self.indicatorView.frame = frame;
}

#pragma mark - event response
- (void)itemPressed:(UIButton*)button{
    if(button.tag == self.selectedIndex) return;
    self.selectedIndex = button.tag;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.indicatorView.frame;
        frame.origin.x = self.selectedIndex*frame.size.width;
        self.indicatorView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    if((self.delegate != nil) && [self.delegate respondsToSelector:@selector(tabBardidSelectIndex:)]){
        [self.delegate tabBardidSelectIndex:self.selectedIndex];
    }
}

#pragma mark - getters and setters
- (void)setItemTitles:(NSArray *)itemTitles{
    _itemTitles = itemTitles;
    if(self.items.count > 0){
        for(UIButton *item in self.items){
            [item removeFromSuperview];
        }
        [self.items removeAllObjects];
    }
    for(NSInteger i = 0; i < _itemTitles.count; i++){
        NSString *title = _itemTitles[i];
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.items addObject:item];
    }
    for(UIButton *item in self.items){
        [self addSubview:item];
    }
    [self addSubview:self.indicatorView];
}

- (NSMutableArray*)items{
    if(_items == nil){
        _items = [NSMutableArray array];
    }
    return _items;
}

- (UIImageView*)indicatorView{
    if(_indicatorView == nil){
        _indicatorView = [UIImageView new];
        _indicatorView.backgroundColor = COLOR_WITH_HEX(0x3C9ED2);
    }
    return _indicatorView;
}

@end
