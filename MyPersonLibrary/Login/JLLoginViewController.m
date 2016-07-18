//
//  JLLoginViewController.m
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import "JLLoginViewController.h"
#import "NSString+MD5.h"
#import "KeychainItemWrapper.h"

@interface JLLoginViewController ()

@end

@implementation JLLoginViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender {
    
    if ((self.nameTextField.text.length == 0) || (self.passwordTextField.text.length == 0)) {
        [self showErrorWithMessage:@"用户名或密码不能为空"];
    }else {
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:@"JLAPPNAME" accessGroup:nil];
        if ([self.nameTextField.text isEqualToString:[keychain objectForKey:(__bridge id)kSecAttrAccount]]) {
            if ([[self.passwordTextField.text MD5] isEqualToString:[keychain objectForKey:(__bridge id)kSecValueData]]) {
                if ([self.delegate respondsToSelector:@selector(loginWithSuccess)]) {
                    [self.delegate loginWithSuccess];
                }
            }else {
                [self showErrorWithMessage:@"密码错误"];
            }
        }else {
            [self showErrorWithMessage:@"用户名错误"];
        }
    }
    
}

- (IBAction)cancelLogin:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loginCancelled)]) {
        [self.delegate loginCancelled];
    }
}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:NO completion:nil];
}
@end
