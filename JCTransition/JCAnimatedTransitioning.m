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
        }

    } else {

        // 获取fromeView，对于销毁动画来说，presenting是fromView,presented是toView
        UIView *fromView =
            [transitionContext viewForKey:UITransitionContextFromViewKey];

        // 设置动画
        if (self.destructionAnimationBlock) {
            self.destructionAnimationBlock(fromView, transitionContext);
        }
    }
}

@end
