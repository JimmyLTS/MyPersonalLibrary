//
//  JLLoginViewController.h
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLLoginViewControllerDelegate <NSObject>

- (void)loginWithSuccess;
- (void)loginWithError;
- (void)loginCancelled;

@end

@interface JLLoginViewController : UIViewController

@property (nonatomic, assign) id<JLLoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)cancelLogin:(UIButton *)sender;

@end
