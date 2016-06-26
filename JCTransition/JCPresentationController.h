//
//  JCPresentationController.h
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCPresentationController : UIPresentationController

/** presented的位置和大小 */
@property(assign, nonatomic) CGRect presentedRect;


/**
 当转场后的控制器view小于转场前控制器的View，
 那么点击presenting的View是没有任何反应的。

 如果设置为YES，则为presenting添加手势，默认为NO
 */
@property (assign, nonatomic, getter=isPresentingGestureRecognizerEnabled) BOOL presentingGestureRecognizerEnabled;

@end
