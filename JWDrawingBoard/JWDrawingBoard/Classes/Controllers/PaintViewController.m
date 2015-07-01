//
//  PaintViewController.m
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import "PaintViewController.h"
#import "ToolView.h"
#import "PaintView.h"
#import "ColorPickerView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface PaintViewController () <ColorViewPickerDelegate>

@end

@implementation PaintViewController
{
    PaintView           *_mainView;
    ToolView            *_toolView;
    ColorPickerView     *_colorPicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initalPaintView];
}
- (void)initalPaintView {
    /*
     1.创建画板
     */
    WS(ws);
    _mainView = [PaintView new];
    _mainView.backgroundColor = RGBCOLOR(243, 213, 37);
    [self.view addSubview:_mainView];
    /*
     2.给画板View添加约束
     */
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).insets(UIEdgeInsetsMake(0, 0, 0, 80));
    }];
    /*
     3.创建工具栏
     */
    _toolView = [ToolView new];
    _toolView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_toolView];
    
    /*
     4.给工具栏添加约束
     */
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.view.mas_right);
        make.left.mas_equalTo(_mainView.mas_right);
        make.top.mas_equalTo(ws.view.mas_top);
        make.bottom.mas_equalTo(ws.view.mas_bottom);
    }];
    /**
     *  添加颜色选取
     */
    if (!_colorPicker) {
        _colorPicker = [ColorPickerView new];
        _colorPicker.delegate = self;
        _colorPicker.alpha = 0.0;
        [self.view addSubview:_colorPicker];
        [_colorPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.right.mas_equalTo(_toolView.mas_left).offset(-5);
            make.top.mas_equalTo(_toolView.colorPicker.mas_top).offset(10);
        }];
        
    }
    /*
     5.工具栏事件
     */
    [_toolView.undoBtn addTarget:self action:@selector(undo) forControlEvents:UIControlEventTouchUpInside];
//    [_toolView.redoBtn addTarget:self action:@selector(redo) forControlEvents:UIControlEventTouchUpInside];
    [_toolView.clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [_toolView.colorPicker addTarget:self action:@selector(color:) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  手机翻转时，重新绘画
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    if(_mainView) [_mainView updateView];
}
/**
 *  撤销
 */
- (void)undo {
    [_mainView undo];
}
/**
 *  回退
 */
- (void)redo {
    [_mainView redo];
}
/**
 *  清空
 */
- (void)clear {
    [_mainView clear];
}
/**
 *  选择画笔颜色
 */
- (void)color:(UIButton *)sender {
    sender.selected = !sender.selected;
    BOOL isSelect = sender.selected;
    if (isSelect) {
        [self showColorView];
    }else {
        [self hideColorView];
    }
}
/**
 *  展开colorView
 */
- (void)showColorView {
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _colorPicker.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  隐藏colorview
 */
- (void)hideColorView {
    [UIView animateWithDuration:0.3 animations:^{
        _colorPicker.alpha = 0;
    }];
}
#pragma mark - ColorPickerDelegate
- (void)didSelectColor:(UIColor *)color {
    [_mainView setDrawColor:color];
    [self hideColorView];
    _toolView.colorPicker.selected = NO;
}
@end
