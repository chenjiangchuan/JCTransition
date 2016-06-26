//
//  JCTransitioningDelegate.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//
//  遵循UIViewControllerTransitioningDelegate协议，用来告诉系统哪个控制器负责“转场动画”，
//  以及哪个对象负责弹出时的动画和销毁时的动画
//

#import "JCAnimatedTransitioning.h"
#import "JCPresentationController.h"
#import "JCTransitioningDelegate.h"

@interface JCTransitioningDelegate ()

/** 转场前控制器 */
@property(strong, nonatomic) UIViewController *presentingVC;

/** 转场后控制器 */
@property(strong, nonatomic) UIViewController *presentedVC;

/** 转场模式 */
@property(assign, nonatomic) JCTransitionMode JCTransitionMode;

@end

@implementation JCTransitioningDelegate

// 初始化对象方法和类方法
#pragma mark - Init Object and Class method
/**
 *  初始化
 *
 *  @param presentingVC 转场前控制器
 *  @param presentedVC  转场后控制器
 *
 *  @return self
 */
- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC {
    if (self = [super init]) {
        self.presentingVC = presentingVC;
        self.presentedVC = presentedVC;
        self.presentingGestureRecognizerEnabled = NO;
    }
    return self;
}

/**
 *  初始化
 *
 *  @param presentingVC              转场前控制器
 *  @param presentedVC               转场后控制器
 *  @param popUpAnimationBlock       实现弹出时的动画
 *  @param destructionAnimationBlock 实现销毁是的动画
 *
 *  @return self
 */
- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC
              WithPopUpAnimation:(popUpAnimationBlock)popUpAnimationBlock
        WithDestructionAnimation:
            (destructionAnimationBlock)destructionAnimationBlock {

    if (self = [self initWithPresentingViewController:presentingVC
                              presentedViewController:presentedVC]) {
        self.popUpAnimationBlock = [popUpAnimationBlock copy];
        self.destructionAnimationBlock = [destructionAnimationBlock copy];
    }
    return self;
}

- (instancetype)
initWithPresentingViewController:(UIViewController *)presentingVC
         presentedViewController:(UIViewController *)presentedVC
              withTransitionMode:(JCTransitionMode)JCTransitionMode {
    if (self = [self initWithPresentingViewController:presentingVC
                              presentedViewController:presentedVC]) {
        self.JCTransitionMode = JCTransitionMode;
    }
    return self;
}

+ (instancetype)animatedTransitioningWithPresentingViewController:
                    (UIViewController *)presentingVC
                                          presentedViewController:
                                              (UIViewController *)presentedVC {

    return [[self alloc] initWithPresentingViewController:presentingVC
                                  presentedViewController:presentedVC];
}

+ (instancetype)animatedTransitioningWithPresentingViewController:
                    (UIViewController *)presentingVC
                                          presentedViewController:
                                              (UIViewController *)presentedVC
                                               WithPopUpAnimation:
                                                   (popUpAnimationBlock)
                                                       popUpAnimationBlock
                                         WithDestructionAnimation:
                                             (destructionAnimationBlock)
                                                 destructionAnimationBlock {

    return [[self alloc]
        initWithPresentingViewController:presentingVC
                 presentedViewController:presentedVC
                      WithPopUpAnimation:popUpAnimationBlock
                WithDestructionAnimation:destructionAnimationBlock];
}

+ (instancetype)animatedTransitioningWithPresentingViewController:
                    (UIViewController *)presentingVC
                                          presentedViewController:
                                              (UIViewController *)presentedVC
                                               withTransitionMode:
                                                   (JCTransitionMode)
                                                       JCTransitionMode {

    return [[self alloc] initWithPresentingViewController:presentingVC presentedViewController:presentedVC withTransitionMode:JCTransitionMode];
}

/**
 *  控制器进行跳转的方法
 */
- (void)jc_jumpToPresentingController {
    // 设置谁来告诉系统：哪个控制器负责进行“转场动画”；哪个负责弹出时动画；哪个负责销毁时动画
    self.presentedVC.transitioningDelegate = self;

    // 设置弹出模式为自定义
    self.presentedVC.modalPresentationStyle = UIModalPresentationCustom;

    // 跳转控制器
    [self.presentingVC presentViewController:self.presentedVC
                                    animated:YES
                                  completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
/**
 *  用来告诉系统谁负责进行“转场动画弹出”控制器
 *
 *  @param presented  转场后的控制器
 *  @param presenting 转场前的控制器
 *  @param source
 *
 *  @return 负责进行“转场动画弹出”的控制器对象
 */
- (nullable UIPresentationController *)
presentationControllerForPresentedViewController:(UIViewController *)presented
                        presentingViewController:(UIViewController *)presenting
                            sourceViewController:(UIViewController *)source {

    JCPresentationController *pc = [[JCPresentationController alloc]
        initWithPresentedViewController:presented
               presentingViewController:presenting];

    [pc setPresentingGestureRecognizerEnabled:self.presentingGestureRecognizerEnabled];
    [pc setPresentedRect:self.presentedRect];

    return pc;
}

/**
 *  告诉系统谁负责弹出时的转场动画
 *  当弹出控制器时调用
 *
 *  @param presented  转场后的控制器
 *  @param presenting 转场前的控制器
 *  @param source
 *
 *  @return 负责弹出时的转场动画的对象
 */
- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
                     presentingController:(UIViewController *)presenting
                         sourceController:(UIViewController *)source {

    return [self setAnimatedTransition:YES];
}

/**
 *  告诉系统谁负责销毁“转场后控制器”时的动画
 *  当销毁控制器时调用
 *
 *  @param dismissed
 *
 *  @return 负责销毁时动画的对象
 */
- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed {

    return [self setAnimatedTransition:NO];
}

#pragma mark - Private Methods
- (JCAnimatedTransitioning *)setAnimatedTransition:(BOOL)presented {

    JCAnimatedTransitioning *animatedTransition =
        [[JCAnimatedTransitioning alloc] init];

    animatedTransition.presented = presented;
    animatedTransition.popUpAnimationBlock = self.popUpAnimationBlock;
    animatedTransition.destructionAnimationBlock =
        self.destructionAnimationBlock;
    animatedTransition.JCTransitionMode = self.JCTransitionMode;

    return animatedTransition;
}

@end
