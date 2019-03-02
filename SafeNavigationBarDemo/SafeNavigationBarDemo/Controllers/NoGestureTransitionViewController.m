//
//  NoGestureTransitionViewController.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "NoGestureTransitionViewController.h"
#import "UINavigationController+SafeNavigationBar.h"

@interface NoGestureTransitionViewController ()

@end

@implementation NoGestureTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredGestureTransitionDisabled = YES;
}


@end
