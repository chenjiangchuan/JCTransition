# JCTransitionExample转场动画的简单封装

## 用法

比如：
控制器A ----跳转到---> 控制器B 

只要在控制器A声明一个JCTransitioningDelegate属性，然后初始化即可：

```
- (JCTransitioningDelegate *)transitionDelegate {
    if (_transitionDelegate == nil) {
        _transitionDelegate = [[JCTransitioningDelegate alloc] initWithPresentingViewController:self
            presentedViewController:self.presentedVC
            WithPopUpAnimation:^(UIView *view, id<UIViewControllerContextTransitioning> transitionContext) {
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
            WithDestructionAnimation:^(UIView *view, id<UIViewControllerContextTransitioning> transitionContext) {
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
    }
    return _transitionDelegate;
}
```
