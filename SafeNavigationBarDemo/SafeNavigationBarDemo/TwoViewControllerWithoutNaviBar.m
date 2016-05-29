//
//  TwoViewControllerWithoutNaviBar.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "TwoViewControllerWithoutNaviBar.h"
#import "UINavigationController+SafeNavigationBar.h"

@interface TwoViewControllerWithoutNaviBar ()

@end

@implementation TwoViewControllerWithoutNaviBar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.safe_navigationBarHidden = YES;
}
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
