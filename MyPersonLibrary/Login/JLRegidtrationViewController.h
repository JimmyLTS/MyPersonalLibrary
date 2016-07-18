//
//  JLRegidtrationViewController.h
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLRegidtrationViewControllerDelegate <NSObject>

- (void)registeredWithSuccess;
- (void)registeredWithError;
- (void)cancelRegistration;

@end

@interface JLRegidtrationViewController : UIViewController

@property (nonatomic, assign) id<JLRegidtrationViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)registerUser:(UIButton *)sender;
- (IBAction)cancelRegistration:(UIButton *)sender;

@end
