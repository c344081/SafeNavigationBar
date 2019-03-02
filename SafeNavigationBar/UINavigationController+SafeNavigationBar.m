//
//  UINavigationController+SafeNavigationBar.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "UINavigationController+SafeNavigationBar.h"
#import <objc/runtime.h>

@interface UINavigationController () <UINavigationControllerDelegate>

@end


@implementation UINavigationController (SafeNavigationBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_pushViewController:animated:)), class_getInstanceMethod(self, @selector(pushViewController:animated:)));
        
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popViewControllerAnimated:)), class_getInstanceMethod(self, @selector(popViewControllerAnimated:)));
        
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popToViewController:animated:)), class_getInstanceMethod(self, @selector(popToViewController:animated:)));
        
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popToRootViewControllerAnimated:)), class_getInstanceMethod(self, @selector(popToRootViewControllerAnimated:)));
        
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_setViewControllers:animated:)), class_getInstanceMethod(self, @selector(setViewControllers:animated:)));
    });
}

- (void)setSafe_isTransitioning:(BOOL)safe_isTransitioning {
    objc_setAssociatedObject(self, @selector(safe_isTransitioning), @(safe_isTransitioning), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)safe_isTransitioning {
    return [objc_getAssociatedObject(self, @selector(safe_isTransitioning)) boolValue];
}

- (void)safe_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self safe_pushViewController:viewController animated:animated];
    // no animation means no transition
    if (animated) {
        self.safe_isTransitioning = YES;
    }
}

- (UIViewController *)safe_popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [self safe_popViewControllerAnimated:animated];
    // actually has a pop animation
    if (animated && viewController) {
        self.safe_isTransitioning = YES;
    }
    return viewController;
}

- (NSArray<UIViewController *> *)safe_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray<UIViewController *> *viewControllers = [self safe_popToViewController:viewController animated:animated];
    if (animated && viewControllers.count > 0) {
        self.safe_isTransitioning = YES;
    }
    return viewControllers;
}

- (NSArray<UIViewController *> *)safe_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray<UIViewController *> *viewControllers = [self safe_popToRootViewControllerAnimated:animated];
    if (animated && viewControllers.count > 0) {
        self.safe_isTransitioning = YES;
    }
    return viewControllers;
}

- (void)safe_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self safe_setViewControllers:viewControllers animated:animated];
    // no animation means no transition
    if (animated) {
        self.safe_isTransitioning = YES;
    }
}

@end


@implementation UIViewController (SafeNavigationBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self,
                                                               @selector(safe_viewWillAppear:)),
                                       class_getInstanceMethod(self,
                                                               @selector(viewWillAppear:)));
        
        method_exchangeImplementations(class_getInstanceMethod(self,
                                                               @selector(safe_viewDidAppear:)),
                                       class_getInstanceMethod(self,
                                                               @selector(viewDidAppear:)));
    });
}


- (BOOL)preferredGestureTransitionDisabled {
    return [objc_getAssociatedObject(self, @selector(preferredGestureTransitionDisabled)) boolValue];
}

- (void)setPreferredGestureTransitionDisabled:(BOOL)preferredGestureTransitionDisabled {
    objc_setAssociatedObject(self, @selector(preferredGestureTransitionDisabled), @(preferredGestureTransitionDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)my_navigationBarHidden {
    return [objc_getAssociatedObject(self, @selector(my_navigationBarHidden)) boolValue];
}

- (void)setMy_navigationBarHidden:(BOOL)my_navigationBarHidden {
    objc_setAssociatedObject(self, @selector(my_navigationBarHidden), @(my_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)preferredOriginalNavigationBarHidden {
    return [objc_getAssociatedObject(self, @selector(preferredOriginalNavigationBarHidden)) boolValue];
}

- (void)setPreferredOriginalNavigationBarHidden:(BOOL)preferredOriginalNavigationBarHidden {
    objc_setAssociatedObject(self, @selector(preferredOriginalNavigationBarHidden), @(preferredOriginalNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - life circle
- (void)safe_viewWillAppear:(BOOL)animated {
    // the viewController should be the navigationController's childViewCpontroller
    // in case the viewController has a childViewController, we don't want the childViewController
    // to override the navigationBar's behavior
    if (!self.preferredOriginalNavigationBarHidden && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [self.navigationController setNavigationBarHidden:self.my_navigationBarHidden animated:animated];
    }
    [self safe_viewWillAppear:animated];
}

- (void)safe_viewDidAppear:(BOOL)animated {
    // in case navigationItem flash back to last viewController's navigationItem
    // this can happen when a vc without navibar(A) cancel a gesture pop, then actually back to B
    // next, B(without navibar) push to C(with navibar), and C push to D(with navibar)
    // then the navigationitem on D will flash back to the navigationItme of C
    // in this case the `navigationItems` hold by navigationController is correct
    // also be carefull when cancel a pop gesture in D
    if (!self.preferredOriginalNavigationBarHidden && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        if (self.my_navigationBarHidden) {
            // in case user didn't finish pop
            // need to reset the navigationBar
            UINavigationBar *naviBar = [[UINavigationBar alloc] init];
            [self.navigationController setValue:naviBar forKey:@"navigationBar"];
        }
    }
    
    // incase wild behavior caused by statusBarStyle Change
    // e.g previousVC has a different statusBar style
    if (!self.navigationController.navigationBarHidden) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.navigationBarHidden = self.my_navigationBarHidden;
        });
    }
    
    // transition complete
    self.navigationController.safe_isTransitioning = NO;
    
    [self safe_viewDidAppear:animated];
}

@end
