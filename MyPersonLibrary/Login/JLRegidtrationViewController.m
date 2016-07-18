//
//  JLRegidtrationViewController.m
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import "JLRegidtrationViewController.h"
#import "NSString+MD5.h"
#import "KeychainItemWrapper.h"
@interface JLRegidtrationViewController ()

@end

@implementation JLRegidtrationViewController

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

- (IBAction)registerUser:(UIButton *)sender {
    if (([self.nameTextField.text length] == 0) || (self.passwordTextField.text.length == 0)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }else {
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:@"JLAPPNAME" accessGroup:nil];
        [keychain setObject:self.nameTextField.text forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:[self.passwordTextField.text MD5] forKey:(__bridge id)kSecValueData];
        //reading back a value from the keychain for comparision
        //get username [keychain objectForKey:(__bridge id)kSecAttrAccount];
        //get password [keychain objectForKey:(__bridge id)kSecValueData];
        [JLConfigurationHelper setBoolValueForConfigurationKey:kJLRegistered withValue:YES];
        if ([self.delegate respondsToSelector:@selector(registeredWithSuccess)]) {
            [self.delegate registeredWithSuccess];
        }
        
    }
}

- (IBAction)cancelRegistration:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelRegistration)]) {
        [self.delegate cancelRegistration];
    }
}
@end
