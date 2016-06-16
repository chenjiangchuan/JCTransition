//
//  AppDelegate.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import "AppDelegate.h"
#import "JCPresentingVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    JCPresentingVC *vc = [[JCPresentingVC alloc] init];

    self.window.rootViewController = vc;

    [self.window makeKeyAndVisible];

    return YES;
}

@end
