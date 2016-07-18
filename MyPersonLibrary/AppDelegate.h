//
//  AppDelegate.h
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/15.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLRegidtrationViewController.h"
#import "JLLoginViewController.h"
@class JLViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, JLLoginViewControllerDelegate, JLRegidtrationViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JLViewController *viewController;
@property (strong, nonatomic) JLLoginViewController *loginVC;
@property (strong, nonatomic) JLRegidtrationViewController *registrationVC;

@end

