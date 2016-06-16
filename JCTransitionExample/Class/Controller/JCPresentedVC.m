//
//  JCPresentedVC.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import "JCPresentedVC.h"

// define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

// define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface JCPresentedVC ()

/** 测试用 */
@property(strong, nonatomic) UIButton *testBtn;

@end

@implementation JCPresentedVC
// View生命周期相关的方法
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view setAlpha:0.5];

    [self.view addSubview:self.testBtn];
}

/**
 *  改变控件的位置可以在这个方法或者
 *  viewDidLayoutSubviews中实现
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    // 在presented控制器View中添加控件，最好使用自动布局
    [self.testBtn makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(self.view).offset(10);
        make.leftMargin.equalTo(self.view);
        make.height.offset(50);
    }];
}

// 所有button,gestureRecognizer的响应事件都放在这个区域里面
#pragma mark - Event Response
// 要实现touchesBegan，即使什么都不做。否则点击View会出现崩溃。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// View的初始化都交给getter去做了
#pragma mark - getters and setters
- (UIButton *)testBtn {
    if (_testBtn == nil) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_testBtn addTarget:self
                      action:@selector(btnClick)
            forControlEvents:UIControlEventTouchUpInside];
        [_testBtn setTitle:@"跳转后控制器" forState:UIControlStateNormal];
    }
    return _testBtn;
}

@end
