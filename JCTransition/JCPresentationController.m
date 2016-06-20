//
//  JCPresentationController.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//
//  继承UIPresentationController，负责“转场动画弹出”的控制器。
//

#import "JCPresentationController.h"

@implementation JCPresentationController
/**
 *  设置跳转后控制器View的位置和大小
 */
- (void)containerViewWillLayoutSubviews {

    if (CGRectEqualToRect(self.presentedRect, CGRectZero)) {
        // 如果没有设置位置大小，默认为全屏
        self.presentedView.frame = self.containerView.bounds;
    } else {
        self.presentedView.frame = self.presentedRect;
    }
}

/**
 *  弹出动画即将开始
 */
- (void)presentationTransitionWillBegin {
    // 注意：如果通过动画实现自定义转场，这里一定要添加转场后的视图！！！
    [self.containerView addSubview:self.presentedView];
}

/**
 *  弹出动画结束
 *
 *  @param completed 是否完成
 */
- (void)presentationTransitionDidEnd:(BOOL)completed {
}

/**
 *  销毁动画即将开始
 */
- (void)dismissalTransitionWillBegin {
}

/**
 *  销毁动画结束
 *
 *  @param completed 是否完成
 */
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // 同理，销毁后一定要移除转场后控制的视图！！！
    [self.presentedView removeFromSuperview];
}

@end
