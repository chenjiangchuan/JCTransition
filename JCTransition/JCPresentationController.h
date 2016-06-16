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

@end
