//
//  ColorPickerView.h
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorViewPickerDelegate<NSObject>

- (void)didSelectColor:(UIColor *)color;
@end
@interface ColorPickerView : UIView
@property (nonatomic, assign) id<ColorViewPickerDelegate> delegate;
@end
