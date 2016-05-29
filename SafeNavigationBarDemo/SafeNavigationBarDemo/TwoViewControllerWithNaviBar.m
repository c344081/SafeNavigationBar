//
//  TwoViewControllerWithNaviBar.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "TwoViewControllerWithNaviBar.h"

@interface TwoViewControllerWithNaviBar ()

@end

@implementation TwoViewControllerWithNaviBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

- (void)setupNavi {
    self.navigationItem.title = @"Two Title";
}

@end
