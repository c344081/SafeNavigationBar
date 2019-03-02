//
//  UIViewController+Navigation.h
//  SafeNavigationBarDemo
//
//  Created by chenhao on 2018/10/24.
//  Copyright © 2018 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (Navigation)

/**
 是否自动添加自定义返回按钮

 @return 是否添加
 */
- (BOOL)preferredCustomLeftBarButtonItems;

/**
 可用于重写导航栏左侧返回按钮,
 默认返回导航栏上级
 
 @note 对导航栏根控制器无效

 @param sender 发送者
 */
- (void)my_backAction:(id)sender;

/**
 自定义的返回按钮, 有默认实现
 */
@property (nonatomic, strong) UIBarButtonItem *my_customBackItem;

@end

NS_ASSUME_NONNULL_END
