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
@property (nonatomic, assign) BOOL safe_isTransitioning;
@end


@implementation UINavigationController (SafeNavigationBar)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_pushViewController:animated:)), class_getInstanceMethod(self, @selector(pushViewController:animated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popViewControllerAnimated:)), class_getInstanceMethod(self, @selector(popViewControllerAnimated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popToViewController:animated:)), class_getInstanceMethod(self, @selector(popToViewController:animated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(safe_popToRootViewControllerAnimated:)), class_getInstanceMethod(self, @selector(popToRootViewControllerAnimated:)));
}

- (void)setSafe_isTransitioning:(BOOL)safe_isTransitioning {
    objc_setAssociatedObject(self, @selector(safe_isTransitioning), @(safe_isTransitioning), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)safe_isTransitioning {
    return [objc_getAssociatedObject(self, @selector(safe_isTransitioning)) boolValue];
}

- (void)safe_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.safe_isTransitioning) {
        return;
    }
    [self safe_pushViewController:viewController animated:animated];
    // no animation means no transition
    if (animated) {
        self.safe_isTransitioning = YES;
    }
}

- (UIViewController *)safe_popViewControllerAnimated:(BOOL)animated {
    // in case push is in progress
    if (self.safe_isTransitioning) {
        return nil;
    }
    UIViewController *viewController = [self safe_popViewControllerAnimated:animated];
    // actually has a pop animation
    if (animated && viewController) {
        self.safe_isTransitioning = YES;
    }
    return viewController;
}

- (NSArray<UIViewController *> *)safe_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.safe_isTransitioning) {
        return nil;
    }
    NSArray<UIViewController *> *viewControllers = [self safe_popToViewController:viewController animated:animated];
    if (animated && viewControllers.count > 0) {
        self.safe_isTransitioning = YES;
    }
    return viewControllers;
}

- (NSArray<UIViewController *> *)safe_popToRootViewControllerAnimated:(BOOL)animated {
    if (self.safe_isTransitioning) {
        return nil;
    }
    NSArray<UIViewController *> *viewControllers = [self safe_popToRootViewControllerAnimated:animated];
    if (animated && viewControllers.count > 0) {
        self.safe_isTransitioning = YES;
    }
    return viewControllers;
}

@end


@implementation UIViewController (SafeNavigationBar)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self,
                                                           @selector(safe_viewWillAppear:)),
                                   class_getInstanceMethod(self,
                                                           @selector(viewWillAppear:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self,
                                                           @selector(safe_viewDidAppear:)),
                                   class_getInstanceMethod(self,
                                                           @selector(viewDidAppear:)));
}


- (BOOL)forbiddenGestureTransition {
    return [objc_getAssociatedObject(self, @selector(forbiddenGestureTransition)) boolValue];
}

- (void)setForbiddenGestureTransition:(BOOL)forbiddenGestureTransition {
    objc_setAssociatedObject(self, @selector(forbiddenGestureTransition), @(forbiddenGestureTransition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)forbiddenBackButton {
    return [objc_getAssociatedObject(self, @selector(forbiddenBackButton)) boolValue];
}

- (void)setForbiddenBackButton:(BOOL)forbiddenBackButton {
    objc_setAssociatedObject(self, @selector(forbiddenBackButton), @(forbiddenBackButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)safe_navigationBarHidden {
    return [objc_getAssociatedObject(self, @selector(safe_navigationBarHidden)) boolValue];
}

- (void)setSafe_navigationBarHidden:(BOOL)safe_navigationBarHidden {
    objc_setAssociatedObject(self, @selector(safe_navigationBarHidden), @(safe_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)preferredOriginalNavigationBarHidden {
    return objc_getAssociatedObject(self, @selector(preferredOriginalNavigationBarHidden));
}

- (void)setPreferredOriginalNavigationBarHidden:(BOOL)preferredOriginalNavigationBarHidden {
    objc_setAssociatedObject(self, @selector(preferredOriginalNavigationBarHidden), @(preferredOriginalNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)safe_viewWillAppear:(BOOL)animated {
    // the viewController should be the navigationController's childViewCpontroller
    // in case the viewController has a childViewController, we don't want the childViewController
    // to override the navigationBar's behavior
    if (!self.preferredOriginalNavigationBarHidden && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [self.navigationController setNavigationBarHidden:self.safe_navigationBarHidden animated:animated];
    }
    [self safe_viewWillAppear:animated];
}

- (void)safe_viewDidAppear:(BOOL)animated {
    if (!self.preferredOriginalNavigationBarHidden && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        if (self.safe_navigationBarHidden) {
            // in case user didn't finish pop
            // need to restore the navigationBar
            UINavigationBar *naviBar = [[UINavigationBar alloc] init];
            [self.navigationController setValue:naviBar forKey:@"navigationBar"];
        }
    }
    
    // transition complete
    self.navigationController.safe_isTransitioning = NO;
    
    [self safe_viewDidAppear:animated];
}

@end
