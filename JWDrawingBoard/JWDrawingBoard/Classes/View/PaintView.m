//
//  PaintView.m
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import "PaintView.h"
#import "Common.h"
@implementation PaintView
{
    BOOL _isEraser;
}
@synthesize currentLine,linesCompleted,drawColor,drawWidth;

- (id)init {
    self = [super init];
    if (self) {
        linesCompleted = [[NSMutableArray alloc]init];
        drawColor = [UIColor blackColor];
        drawWidth = 5.0f;
        [self setMultipleTouchEnabled:YES];
        [self becomeFirstResponder];
    }
    return self;
}
#pragma mark - 画图主要工作区间
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(ctx, kCGLineCapRound);
    for (Line *line in linesCompleted) {
//        [[line color] set];
        CGContextSetStrokeColorWithColor(ctx, line.color.CGColor);
        CGContextSetLineWidth(ctx, line.width);
        CGContextMoveToPoint(ctx, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(ctx, line.end.x,line.end.y);
        CGContextStrokePath(ctx);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /*
     设置undoManager,用于撤销
     */
    [self.undoManager beginUndoGrouping];
    /*
     获取当前所触摸的点
     */
    for (UITouch *t in touches) {
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:drawColor];
        [newLine setWidth:drawWidth];
        currentLine = newLine;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isCleared) {
        for (UITouch *t in touches) {
            [currentLine setColor:drawColor];
            CGPoint loc = [t locationInView:self];
            [currentLine setEnd:loc];
            
            if (currentLine) {
                if ([Common color:drawColor isEqualToColor:[UIColor clearColor] withTolerance:0.2]) {
                    _isEraser = YES;
                } else {
                    _isEraser = NO;
                    [self addLine:currentLine];
                }
            }
            Line *newLine = [[Line alloc] init];
            [newLine setBegin:loc];
            [newLine setEnd:loc];
            [newLine setColor:drawColor];
            [newLine setWidth:drawWidth];
            currentLine = newLine;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
    [self.undoManager endUndoGrouping];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
}

- (void)endTouches:(NSSet *)touches
{
    if (!isCleared) {
        [self setNeedsDisplay];
    } else {
        isCleared = NO;
    }
}
- (void)addLine:(Line*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [linesCompleted addObject:line];
    [self setNeedsDisplay];
}

- (void)removeLine:(Line*)line
{
    if ([linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}

- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Line *evaluatedLine = (Line*)evaluatedObject;
        return (evaluatedLine.end.x <= point.x-1 || evaluatedLine.end.x > point.x+1) &&
        (evaluatedLine.end.y <= point.y-1 || evaluatedLine.end.y > point.y+1);
    }];
    NSArray *result = [linesCompleted filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [linesCompleted removeObject:result[0]];
    }
}
/**
 *  撤销
 */
- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}
/**
 *  重做
 */
- (void)redo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}
/**
 *  更新页面
 */
- (void)updateView {
    [self setNeedsDisplay];
}

/**
 *  清空
 */
- (void)clear {
    [linesCompleted removeAllObjects];
    [self updateView];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didMoveToWindow
{
    [self becomeFirstResponder];
}
@end
