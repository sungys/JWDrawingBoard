//
//  PaintView.h
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
@interface PaintView : UIView
{
    BOOL isCleared;
}
@property (nonatomic) Line *currentLine;
@property (nonatomic) NSMutableArray *linesCompleted;
@property (nonatomic) UIColor *drawColor;
@property (nonatomic, assign) CGFloat drawWidth;
- (void)undo;
- (void)redo;
- (void)clear;
- (void)updateView;

@end
