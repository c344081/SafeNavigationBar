//
//  UIViewController+Navigation.m
//  SafeNavigationBarDemo
//
//  Created by chenhao on 2018/10/24.
//  Copyright © 2018 chenhao. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>

@implementation UIViewController (Navigation)

- (BOOL)preferredCustomLeftBarButtonItems {
    return NO;
}

- (void)my_backAction:(id)sender {
    if (self.navigationController.viewControllers.count <= 1) { return; }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)my_customBackItem {
    UIBarButtonItem *item = objc_getAssociatedObject(self, _cmd);
    if (!item) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(my_backAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"<<Custom Back" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button sizeToFit];
        item = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return item;
}

- (void)setMy_customBackItem:(UIBarButtonItem *)my_customBackItem {
    objc_setAssociatedObject(self, @selector(my_customBackItem), my_customBackItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
