//
//  HideBackButtonViewController.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "HideBackButtonViewController.h"
#import "UINavigationController+SafeNavigationBar.h"
#import "UIViewController+Navigation.h"

@interface HideBackButtonViewController ()

@end

@implementation HideBackButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

- (void)setupNavi {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.my_customBackItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
