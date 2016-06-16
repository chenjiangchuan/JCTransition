//
//  JCTransitioningDelegate.h
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JCAnimatedTransitioning;

typedef void (^popUpAnimationBlock)(
    UIView *view, id<UIViewControllerContextTransitioning> transitionContext);

typedef void (^destructionAnimationBlock)(
    UIView *view, id<UIViewControllerContextTransitioning> transitionContext);

@interface JCTransitioningDelegate
    : NSObject <UIViewControllerTransitioningDelegate>

// 初始化方法，获取跳转前控制器
- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC;

- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC
              WithPopUpAnimation:(popUpAnimationBlock)popUpAnimationBlock
        WithDestructionAnimation:
            (destructionAnimationBlock)destructionAnimationBlock;

+ (instancetype)animatedTransitioningWithPresentingViewController:
                    (UIViewController *)presentingVC
                                          presentedViewController:
                                              (UIViewController *)presentedVC;

+ (instancetype)
animatedTransitioningWithPresentingViewController:
    (UIViewController *)presentingVC
                          presentedViewController:
                              (UIViewController *)presentedVC
                               WithPopUpAnimation:
                                   (popUpAnimationBlock)popUpAnimationBlock
                         WithDestructionAnimation:(destructionAnimationBlock)
                                                      destructionAnimationBlock;

// 跳转到指定控制器
- (void)jc_jumpToPresentingController;

/**
 *  声明弹出动画回调block
 */
@property(copy, nonatomic) popUpAnimationBlock popUpAnimationBlock;

/**
 *  声明销毁动画回调block
 */
@property(copy, nonatomic) destructionAnimationBlock destructionAnimationBlock;

/** presented的位置和大小 */
@property(assign, nonatomic) CGRect presentedRect;

@end
