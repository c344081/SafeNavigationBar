//
//  OneViewControllerWithoutNaviBar.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "OneViewControllerWithoutNaviBar.h"
#import "UINavigationController+SafeNavigationBar.h"

@interface OneViewControllerWithoutNaviBar ()

@end

@implementation OneViewControllerWithoutNaviBar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.my_navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
