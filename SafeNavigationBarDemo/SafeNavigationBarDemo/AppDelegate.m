//
//  AppDelegate.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MyNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    
    self.window.rootViewController = [[MyNavigationController alloc] initWithRootViewController:homeVc];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (AppDelegate *)sharedAppdelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
