//
//  ToolView.m
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import "ToolView.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

@implementation ToolView
@synthesize undoBtn,redoBtn,colorPicker,clearBtn;
- (id)init {
    self = [super init];
    if (self) {
        [self initalTools];
    }
    return self;
}
- (void)initalTools {
    WS(ws);
    /*
     撤销
     */
    undoBtn = [UIButton new];
    [undoBtn setImage:[UIImage imageNamed:@"undo_normal"] forState:UIControlStateNormal];
    [undoBtn setImage:[UIImage imageNamed:@"undo_click"] forState:UIControlStateHighlighted];
    [undoBtn setImage:[UIImage imageNamed:@"undo_disabled"] forState:UIControlStateDisabled];
    [self addSubview:undoBtn];
    CGFloat padding = 10;
    [undoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top).with.offset(padding);
        make.width.equalTo(undoBtn.mas_height);
        make.centerX.mas_equalTo(ws.mas_centerX);
    }];
    /*
     回退
     */
//    redoBtn = [UIButton new];
//    [redoBtn setTitle:@"回退" forState:UIControlStateNormal];
//    [redoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [redoBtn setBackgroundColor:RGBCOLOR(0, 209, 229)];
////    [self addSubview:redoBtn];
//    
//    [redoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(undoBtn.mas_width);
//        make.height.mas_equalTo(undoBtn.mas_height);
//        make.centerX.mas_equalTo(undoBtn.mas_centerX);
//        make.top.equalTo(undoBtn.mas_bottom).with.offset(padding);
//    }];
    
    /*
     清除
     */
    clearBtn = [UIButton new];
    [clearBtn setImage:[UIImage imageNamed:@"clear_normal"] forState:UIControlStateNormal];
    [clearBtn setImage:[UIImage imageNamed:@"clear_click"] forState:UIControlStateHighlighted];
    [clearBtn setImage:[UIImage imageNamed:@"clear_disabled"] forState:UIControlStateDisabled];
    [self addSubview:clearBtn];
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(undoBtn.mas_width);
        make.height.mas_equalTo(undoBtn.mas_height);
        make.centerX.mas_equalTo(undoBtn.mas_centerX);
        make.top.equalTo(undoBtn.mas_bottom).with.offset(padding);
    }];
    
    /*
     颜色选择器
     */
    colorPicker = [UIButton new];
    [colorPicker setImage:[UIImage imageNamed:@"color_normal"] forState:UIControlStateNormal];
    [colorPicker setImage:[UIImage imageNamed:@"color_click"] forState:UIControlStateHighlighted];
    [colorPicker setImage:[UIImage imageNamed:@"color_disabled"] forState:UIControlStateDisabled];
    colorPicker.selected = NO;
    [self addSubview:colorPicker];
    [colorPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(undoBtn.mas_width);
        make.height.mas_equalTo(undoBtn.mas_height);
        make.centerX.mas_equalTo(undoBtn.mas_centerX);
        make.top.equalTo(clearBtn.mas_bottom).with.offset(padding);
    }];
}

@end
