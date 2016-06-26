//
//  JCPresentingVC.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import "JCPresentedVC.h"
#import "JCPresentingVC.h"
#import "JCTransitioningDelegate.h"

@interface JCPresentingVC ()

/** 负责告诉系统谁来负责自定义动画 */
@property(strong, nonatomic) JCTransitioningDelegate *transitionDelegate;

/** 转场后的控制器 */
@property(strong, nonatomic) JCPresentedVC *presentedVC;

/** 测试Label */
@property(strong, nonatomic) UILabel *testLabel;

@end

@implementation JCPresentingVC
// View生命周期相关的方法
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.testLabel];
}

/**
 *  改变控件的位置可以在这个方法或者
 *  viewDidLayoutSubviews中实现
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.testLabel.frame = (CGRect){{100, 100}, {200, 200}};
}

// 所有button,gestureRecognizer的响应事件都放在这个区域里面
#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.transitionDelegate jc_jumpToPresentingController];
}

// View的初始化都交给getter去做了
#pragma mark - getters and setters
/*
 方式三：不使用模块的动画，自定义自己的动画
 */
- (JCTransitioningDelegate *)transitionDelegate {
    if (_transitionDelegate == nil) {
        _transitionDelegate = [[JCTransitioningDelegate alloc]
                               initWithPresentingViewController:self
                               presentedViewController:self.presentedVC
                               WithPopUpAnimation:^(
                                                    UIView *view,
                                                    id<UIViewControllerContextTransitioning> transitionContext) {

                                   // 在这里自定义弹出时的转场动画
                                   view.alpha = 0.0;

                                   [UIView animateWithDuration:1.5
                                                    animations:^{
                                                        view.alpha = 1.0;
                                                    }
                                                    completion:^(BOOL finished) {
                                                        // 一定要告诉系统转场动画结束
                                                        [transitionContext completeTransition:YES];
                                                    }];

                               }
                               WithDestructionAnimation:^(
                                                          UIView *view,
                                                          id<UIViewControllerContextTransitioning> transitionContext) {
                                   // 在这里自定义销毁时的转场动画
                                   [UIView animateWithDuration:1.5
                                                    animations:^{
                                                        view.alpha = 0.0;
                                                    }
                                                    completion:^(BOOL finished) {
                                                        // 一定要告诉系统转场动画结束
                                                        [transitionContext completeTransition:YES];
                                                    }];
                               }];
        
        // 设置转场后控制器View的位置和大小
        [_transitionDelegate setPresentedRect:(CGRect){{200, 200}, {100, 100}}];
        [_transitionDelegate setPresentingGestureRecognizerEnabled:YES];
    }
    return _transitionDelegate;
}

- (JCPresentedVC *)presentedVC {
    if (_presentedVC == nil) {
        _presentedVC = [[JCPresentedVC alloc] init];
    }
    return _presentedVC;
}

- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.text = @"转场前控制器";
    }
    return _testLabel;
}

@end
