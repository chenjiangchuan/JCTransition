# JCTransitionExample转场动画的简单封装

因目前所学有限，只能从当前阶段的角度去思考一些问题，希望大家提出建议一起完善。
本人邮箱：jiangchuanc@gmail.com

## 用法

比如：
控制器A ----跳转到---> 控制器B 

只要在控制器A声明一个JCTransitioningDelegate属性，然后初始化即可（目前有3种方式）：



```
/*
方式一：使用模块自带的动画，目前只实现了5种方式，后续会添加更多的动画；
不设置转场后控制器的view位置大小，默认位置为左上角(0, 0)，大小全屏。
*/
- (JCTransitioningDelegate *)transitionDelegate {
    if (_transitionDelegate == nil) {

        _transitionDelegate = [JCTransitioningDelegate animatedTransitioningWithPresentingViewController:self 
                                presentedViewController:self.presentedVC 
                                withTransitionMode:JCTransitionModeAlpha];

    }
    return _transitionDelegate;
}

```

```
/*
方式二：手动设置转场后控制器view的位置和大小
*/
- (JCTransitioningDelegate *)transitionDelegate {
    if (_transitionDelegate == nil) {

        _transitionDelegate = [JCTransitioningDelegate animatedTransitioningWithPresentingViewController:self 
                                presentedViewController:self.presentedVC 
                                withTransitionMode:JCTransitionModeAlpha];

        // 设置转场后控制器View的位置和大小
        [_transitionDelegate setPresentedRect:(CGRect){{200, 200}, {100, 100}}];
    }
    return _transitionDelegate;
}
```

```
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
    }
    return _transitionDelegate;
}
```
