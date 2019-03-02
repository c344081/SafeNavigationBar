//
//  OneViewControllerWithNaviBar.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "OneViewControllerWithNaviBar.h"
#import "TwoViewControllerWithNaviBar.h"

@interface OneViewControllerWithNaviBar ()

@end

@implementation OneViewControllerWithNaviBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

- (void)setupNavi {
    self.navigationItem.title = @"One Title";
}

@end
