//
//  JCAnimatedTransitioning.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//
//  遵循UIViewControllerAnimatedTransitioning协议，负责弹出和销毁时的动画。
//

#import "JCAnimatedTransitioning.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation JCAnimatedTransitioning

- (instancetype)initWithPopUpAnimation:(popUpAnimationBlock)popUpAnimationBlock
              WithDestructionAnimation:
                  (destructionAnimationBlock)destructionAnimationBlock {
    if (self = [super init]) {
        self.popUpAnimationBlock = [popUpAnimationBlock copy];
        self.destructionAnimationBlock = [destructionAnimationBlock copy];
    }
    return self;
}

/**
 *  转场时的动画时间
 */
- (NSTimeInterval)transitionDuration:
    (nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

/**
 *  重要的方法！！！
 *
 *  无论是弹出还是销毁，如果有动画，都会调用该方法！
 *
 *  @param transitionContext 转场动画的上下文，通过它能获取转场前后的视图
 */
- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresented) {
        // 获取toView，对于弹出动画来说，presenting是toView，presented是fromView
        UIView *toView =
            [transitionContext viewForKey:UITransitionContextToViewKey];

        // 设置动画
        if (self.popUpAnimationBlock) {
            self.popUpAnimationBlock(toView, transitionContext);
        } else {
            switch (self.JCTransitionMode) {
            case JCTransitionModeFromTopToBottom:
                [self transitionModeFromTopToBottomPopUp:toView
                                   withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromBottomToTop:
                [self transitionModeFromBottomToTopPopUp:toView
                                   withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromLeftToRight:
                [self transitionModeFromLeftToRightPopUp:toView
                                   withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromRightToLeft:
                [self transitionModeFromRightToLeftPopUp:toView
                                   withTransitionContext:transitionContext];
                break;

            case JCTransitionModeAlpha:
                [self transitionModeAlphaPopUp:toView
                         withTransitionContext:transitionContext];
                break;

            default:
                [self defaultPopUpAnimation:toView
                      withTransitionContext:transitionContext];

                break;
            }
        }

    } else {
        // 获取fromeView，对于销毁动画来说，presenting是fromView,presented是toView
        UIView *fromView =
            [transitionContext viewForKey:UITransitionContextFromViewKey];

        // 设置动画
        if (self.destructionAnimationBlock) {
            self.destructionAnimationBlock(fromView, transitionContext);
        } else {
            switch (self.JCTransitionMode) {
            case JCTransitionModeFromTopToBottom:
                [self
                    transitionModeFromTopToBottomDestruction:fromView
                                       withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromBottomToTop:
                [self
                    transitionModeFromBottomToTopDestruction:fromView
                                       withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromLeftToRight:
                [self
                    transitionModeFromLeftToRightDestruction:fromView
                                       withTransitionContext:transitionContext];
                break;

            case JCTransitionModeFromRightToLeft:
                [self
                    transitionModeFromRightToLeftDestruction:fromView
                                       withTransitionContext:transitionContext];
                break;

            case JCTransitionModeAlpha:
                [self transitionModeAlphaDestruction:fromView
                               withTransitionContext:transitionContext];
                break;

            default:
                [self defaultdestructionAnimation:fromView
                            withTransitionContext:transitionContext];

                break;
            }
        }
    }
}

#pragma mark - Private Methods
/**
 *  默认弹出时的转场动画
 */
- (void)defaultPopUpAnimation:(UIView *)view
        withTransitionContext:
            (id<UIViewControllerContextTransitioning>)transitionContext {

    view.alpha = 0.0;
    view.frame = (CGRect){{0, -SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

    [UIView animateWithDuration:1.5
        animations:^{
            view.alpha = 1.0;

            view.frame = (CGRect){{0, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            // 一定要告诉系统转场动画结束
            [transitionContext completeTransition:YES];
        }];
}

/**
 *  默认销毁时的转场动画
 */
- (void)defaultdestructionAnimation:(UIView *)view
              withTransitionContext:
                  (id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:1.5
        animations:^{

            view.frame =
                (CGRect){{0, -SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

            view.alpha = 0.0;

        }
        completion:^(BOOL finished) {
            // 一定要告诉系统转场动画结束
            [transitionContext completeTransition:YES];
        }];
}

/*
 JCTransitionModeFromTopToBottom, // 从上往下
 JCTransitionModeFromBottomToTop, // 从下往上
 JCTransitionModeFromLeftToRight, // 从左往右
 JCTransitionModeFromRightToLeft, // 从右往左
 JCTransitionModeAlpha,           // 透明度变化
 */
#pragma mark - 从上往下
- (void)transitionModeFromTopToBottomPopUp:(UIView *)view
                     withTransitionContext:
                         (id<UIViewControllerContextTransitioning>)
                             transitionContext {

    view.frame = (CGRect){{0, -SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame = (CGRect){{0, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

- (void)transitionModeFromTopToBottomDestruction:(UIView *)view
                           withTransitionContext:
                               (id<UIViewControllerContextTransitioning>)
                                   transitionContext {

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame =
                (CGRect){{0, -SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

#pragma mark - 从下往上
- (void)transitionModeFromBottomToTopPopUp:(UIView *)view
                     withTransitionContext:
                         (id<UIViewControllerContextTransitioning>)
                             transitionContext {

    view.frame = (CGRect){{0, SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame = (CGRect){{0, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

- (void)transitionModeFromBottomToTopDestruction:(UIView *)view
                           withTransitionContext:
                               (id<UIViewControllerContextTransitioning>)
                                   transitionContext {

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame =
                (CGRect){{0, SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

#pragma mark - 从左往右
- (void)transitionModeFromLeftToRightPopUp:(UIView *)view
                     withTransitionContext:
                         (id<UIViewControllerContextTransitioning>)
                             transitionContext {

    view.frame = (CGRect){{-SCREEN_WIDTH, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame = (CGRect){{0, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

- (void)transitionModeFromLeftToRightDestruction:(UIView *)view
                           withTransitionContext:
                               (id<UIViewControllerContextTransitioning>)
                                   transitionContext {

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame =
                (CGRect){{-SCREEN_WIDTH, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

#pragma mark - 从右往左
- (void)transitionModeFromRightToLeftPopUp:(UIView *)view
                     withTransitionContext:
                         (id<UIViewControllerContextTransitioning>)
                             transitionContext {

    view.frame = (CGRect){{SCREEN_WIDTH, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

    [UIView animateWithDuration:1.5
        animations:^{
            view.frame = (CGRect){{0, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

- (void)transitionModeFromRightToLeftDestruction:(UIView *)view
                           withTransitionContext:
                               (id<UIViewControllerContextTransitioning>)
                                   transitionContext {
    [UIView animateWithDuration:1.5
        animations:^{
            view.frame =
                (CGRect){{SCREEN_WIDTH, 0}, {SCREEN_WIDTH, SCREEN_HEIGHT}};
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

#pragma mark - 透明度变化
- (void)transitionModeAlphaPopUp:(UIView *)view
           withTransitionContext:
               (id<UIViewControllerContextTransitioning>)transitionContext {

    view.alpha = 0.0f;

    [UIView animateWithDuration:1.5
        animations:^{
            view.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

- (void)transitionModeAlphaDestruction:(UIView *)view
                 withTransitionContext:
                     (id<UIViewControllerContextTransitioning>)
                         transitionContext {
    [UIView animateWithDuration:1.5
        animations:^{
            view.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
}

@end
