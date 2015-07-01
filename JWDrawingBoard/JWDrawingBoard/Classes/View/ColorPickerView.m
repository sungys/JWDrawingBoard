//
//  ColorPickerView.m
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import "ColorPickerView.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
@implementation ColorPickerView
- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initalView];
    }
    return self;
}
- (void)initalView {
    WS(ws);
    UIScrollView *sv = [UIScrollView new];
    [self addSubview:sv];
    sv.backgroundColor = [UIColor clearColor];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    UIView *container = [UIView new];
    [sv addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(sv);
        make.height.mas_equalTo(sv.mas_height);
    }];
    UIButton *lastV = nil;
    CGFloat padding = 8.0f;
    
    for (int i = 1; i <= 8; i++) {
        UIButton *subV = [UIButton new];
        [container addSubview:subV];
        subV.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        [subV addTarget:self action:@selector(chooseColor:) forControlEvents:UIControlEventTouchUpInside];
        
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(container).with.offset(padding);
            make.bottom.equalTo(container).with.offset(-padding);
            make.width.mas_equalTo(subV.mas_height);
            if (lastV) {
                make.left.equalTo(lastV.mas_right).and.offset(padding);
            }else {
                make.left.equalTo(container.mas_left).and.offset(padding);
            }
        }];
        lastV = subV;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastV.mas_right);
    }];

}
/**
 *  选取颜色
 */
- (void)chooseColor:(UIButton *)btn {
    UIColor *selectColor = btn.backgroundColor;
    /*
      代理返回颜色
     */
    if ([_delegate respondsToSelector:@selector(didSelectColor:)]) {
        [_delegate didSelectColor:selectColor];
    }
}
@end
