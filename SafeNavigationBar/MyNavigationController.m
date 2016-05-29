//
//  TANavigationController.m
//
//  Created by c344081 on 15/12/7.
//  Copyright © 2015年 c344081. All rights reserved.
//

#import "MyNavigationController.h"
#import "UINavigationController+SafeNavigationBar.h"
#import <objc/runtime.h>

@interface MyNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation MyNavigationController

+ (void)initialize {
    UINavigationBar *naviBar = [UINavigationBar appearance];
    naviBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkGrayColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 恢复边缘滑动手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.delegate = self;
}

#pragma mark - 返回上一级
- (void)backBtnClicked {
    [self popViewControllerAnimated:YES];
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.lastObject.forbiddenGestureTransition) {  // 禁用滑动返回
        return NO;
    }
    BOOL viewTransitionInProgress = [objc_getAssociatedObject(self, NSSelectorFromString(@"viewTransitionInProgress")) boolValue];
    if (viewTransitionInProgress) {
        return NO;
    }
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - navigationController delegate

// 调用时机: 在 viewWillAppear: 之后
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果不是rootVc,更改左侧返回按钮
    if (self.childViewControllers.count > 1) {
        if (viewController.forbiddenBackButton) {
            return;
        }
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"<<Custom Back" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
}

@end
