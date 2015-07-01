//
//  AppDelegate.m
//  JWDrawingBoard
//
//  Created by cuizm on 15/6/30.
//  Copyright (c) 2015年 sunjws. All rights reserved.
//

#import "AppDelegate.h"
#import "PaintViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    PaintViewController *vc = [[PaintViewController alloc]init];
    self.window.rootViewController = vc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
