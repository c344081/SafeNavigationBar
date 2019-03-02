//
//  UINavigationController+SafeNavigationBar.h
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SafeNavigationBar)
/** 是否正在转场*/
@property(nonatomic, assign) BOOL safe_isTransitioning;
@end


@interface UIViewController (SafeNavigationBar)
/**
 是否能够滑动返回, 可重写`getter`
 */
@property(nonatomic, assign) BOOL preferredGestureTransitionDisabled;

/**
 隐藏导航栏
 
 @note 仍然会隐式调用, 但尽量不要使用此属性, 如果要隐藏导航栏请选择设置为透明
 */
@property (nonatomic, assign) BOOL my_navigationBarHidden;
/** 使用原生的隐藏和显示, 注意还原设置*/
@property (nonatomic, assign) BOOL preferredOriginalNavigationBarHidden;
@end
