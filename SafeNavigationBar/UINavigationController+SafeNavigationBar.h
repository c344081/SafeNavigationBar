//
//  UINavigationController+SafeNavigationBar.h
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SafeNavigationBar)

@end


@interface UIViewController (SafeNavigationBar)
/** 是否能够滑动返回*/
@property(nonatomic, assign) BOOL forbiddenGestureTransition;
/** 是否需要设置统一的返回键*/
@property(nonatomic, assign) BOOL forbiddenBackButton;
/** 安全隐藏导航栏 */
@property (nonatomic, assign) BOOL safe_navigationBarHidden;
@end