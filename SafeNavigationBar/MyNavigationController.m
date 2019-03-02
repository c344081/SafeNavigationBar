//
//  TANavigationController.m
//
//  Created by c344081 on 15/12/7.
//  Copyright © 2015年 c344081. All rights reserved.
//

#import "MyNavigationController.h"
#import "UINavigationController+SafeNavigationBar.h"
#import <objc/runtime.h>
#import "UIViewController+Navigation.h"

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

#pragma mark - gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.lastObject.preferredGestureTransitionDisabled) {  // 禁用滑动返回
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
    // 更新返回按钮
    if (self.viewControllers.count <= 1) { return; }
    if (viewController.preferredCustomLeftBarButtonItems) { return; }
    // NOTE: - 有默认按钮
    viewController.navigationItem.leftBarButtonItem = viewController.my_customBackItem;
}

@end
