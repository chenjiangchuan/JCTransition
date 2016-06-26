//
//  JCTransitioningDelegate.h
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JCAnimatedTransitioning.h"

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

- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC
              withTransitionMode:(JCTransitionMode)JCTransitionMode;

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

+ (instancetype)animatedTransitioningWithPresentingViewController:
                    (UIViewController *)presentingVC
                                          presentedViewController:
                                              (UIViewController *)presentedVC
                                               withTransitionMode:
                                                   (JCTransitionMode)
                                                       JCTransitionMode;

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

/* 
    当转场后控制器presented的view不能覆盖转场前控制器presenting的view，
    用户点击presenting View，presented View不会消失。
    只有点击在presented View上，才会让presented View消失。
    
    为了解决这个问题，在presenting View上添加了一个手势，这样当点击事件在presenting View
    上也能让presented View消失。
 
    但是，presented View将不能响应自己的事件。
 
    isPresentingGestureRecognizerEnabled默认为NO
 */
/** 为转场前控制器添加手势 */
@property (assign, nonatomic, getter=isPresentingGestureRecognizerEnabled) BOOL presentingGestureRecognizerEnabled;

@end
