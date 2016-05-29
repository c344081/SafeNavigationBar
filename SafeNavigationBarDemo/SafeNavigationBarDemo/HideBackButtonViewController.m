//
//  HideBackButtonViewController.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "HideBackButtonViewController.h"
#import "UINavigationController+SafeNavigationBar.h"

@interface HideBackButtonViewController ()

@end

@implementation HideBackButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

- (void)setupNavi {
    self.forbiddenBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
