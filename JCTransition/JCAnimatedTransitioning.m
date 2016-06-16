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
              WithDestructionAnimation:(destructionAnimationBlock)destructionAnimationBlock {
    if (self = [super init]) {
        self.popUpAnimationBlock = [popUpAnimationBlock copy];
        self.destructionAnimationBlock = [destructionAnimationBlock copy];
    }
    return self;
}

/**
 *  转场时的动画时间
 */
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

/**
 *  重要的方法！！！
 *
 *  无论是弹出还是销毁，如果有动画，都会调用该方法！
 *
 *  @param transitionContext 转场动画的上下文，通过它能获取转场前后的视图
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresented) {
        // 获取toView，对于弹出动画来说，presenting是toView，presented是fromView
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

        // 设置动画
        if (self.popUpAnimationBlock) {
            self.popUpAnimationBlock(toView, transitionContext);
        } else {
            [self defaultPopUpAnimation:toView withTransitionContext:transitionContext];
        }

    } else {
        // 获取fromeView，对于销毁动画来说，presenting是fromView,presented是toView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

        // 设置动画
        if (self.destructionAnimationBlock) {
            self.destructionAnimationBlock(fromView, transitionContext);
        } else {
            [self defaultdestructionAnimation:fromView withTransitionContext:transitionContext];
        }
    }
}

#pragma mark - Private Methods
/**
 *  默认弹出时的转场动画
 */
- (void)defaultPopUpAnimation:(UIView *)view
        withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    view.alpha = 0.0;

    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = (CGRect){{0, -height}, {width, height}};

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
              withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:1.5
        animations:^{

            view.frame = (CGRect){{0, -SCREEN_HEIGHT}, {SCREEN_WIDTH, SCREEN_HEIGHT}};

            view.alpha = 0.0;

        }
        completion:^(BOOL finished) {
            // 一定要告诉系统转场动画结束
            [transitionContext completeTransition:YES];
        }];
}

@end
