//
//  JCAnimatedTransitioning.h
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JCTransitionMode) {
    JCTransitionModeFromTopToBottom, // 从上往下
    JCTransitionModeFromBottomToTop, // 从下往上
    JCTransitionModeFromLeftToRight, // 从左往右
    JCTransitionModeFromRightToLeft, // 从右往左
    JCTransitionModeAlpha,           // 透明度变化
};

/**
 *  实现弹出时的动画
 *
 *  @param view              presented控制器
 *  @param transitionContext
 * 转场上下文，为了转场动画结束后调用completeTransition方法
 *                           告诉系统动画完成
 */
typedef void (^popUpAnimationBlock)(
    UIView *view, id<UIViewControllerContextTransitioning> transitionContext);

/**
 *  实现销毁时的动画
 *
 *  @param view              presented控制器
 *  @param transitionContext
 * 转场上下文，为了转场动画结束后调用completeTransition方法
 *                           告诉系统动画完成
 */

typedef void (^destructionAnimationBlock)(
    UIView *view, id<UIViewControllerContextTransitioning> transitionContext);

@interface JCAnimatedTransitioning
    : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPopUpAnimation:(popUpAnimationBlock)popUpAnimationBlock
              WithDestructionAnimation:
                  (destructionAnimationBlock)destructionAnimationBlock;

/**
 *  公开的属性，用它来判断视图是弹出还是销毁
 *  TRUE：弹出动画；FLASE：销毁动画。
 */
@property(assign, nonatomic, getter=isPresented) BOOL presented;

/**
 *  声明弹出动画回调block
 */
@property(copy, nonatomic) popUpAnimationBlock popUpAnimationBlock;

/**
 *  声明销毁动画回调block
 */
@property(copy, nonatomic) destructionAnimationBlock destructionAnimationBlock;

@property(assign, nonatomic) JCTransitionMode JCTransitionMode;

@end
