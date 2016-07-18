//
//  AppDelegate.m
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/15.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import "AppDelegate.h"
#import "JLViewController.h"
#import "JLCrashHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)installYDCrashHandler
{
    InstallCrashExceptionHandler();
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (kJLInstallCrashHandler)
    {
        [self performSelector:@selector(installYDCrashHandler) withObject:nil afterDelay:0];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (![JLConfigurationHelper getBoolValueForConfigurationKey:kJLFirstLaunch])
        [JLConfigurationHelper setApplicationStartupDefaults];
    
    if (kJLActivateGPSOnStartUp)
    {
        //Start your CLLocationManager here if you're application needs the GPS
    }
    
    if (kJLRegistrationRequired && ![JLConfigurationHelper getBoolValueForConfigurationKey:kJLRegistered])
    {
        //Create an instance of your RegistrationViewcontroller
        self.registrationVC =[[JLRegidtrationViewController alloc] init];
        //Set the delegate
        self.registrationVC.delegate=self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = _registrationVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
        
    }
    else
    {
        // you arrive here if either the registration is not required or yet achieved
        if (kJLLoginRequired)
        {
            self.loginVC= [[JLLoginViewController alloc] init];
            self.loginVC.delegate=self;
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = _loginVC;
            self.window.backgroundColor = [UIColor clearColor];
            [self.window makeKeyAndVisible];
        }
        else
        {
            self.viewController= [[JLViewController alloc] init];
            self.window.rootViewController =self.viewController;
            [self.window makeKeyAndVisible];
        }
    }
    
    return YES;
}
#pragma Registration Delegates
-(void)registeredWithError
{
    //called from RegistrationViewcontroller if registration failed
}
-(void)registeredWithSuccess
{
    //called from RegistrationViewcontroller if the registration with success
    //
    if (kJLShowLoginAfterRegistration)
    {
        self.loginVC = [[JLLoginViewController alloc] init];
        self.loginVC.delegate=self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = self.loginVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
    }
    else
    {
        self.viewController= [[JLViewController alloc] init];
        self.window.rootViewController =self.viewController;
        [self.window makeKeyAndVisible];
    }
}
-(void)cancelRegistration
{
    //called from RegistrationViewcontroller if cancel is pressed
}
#pragma Login delegates
-(void)loginWithSuccess
{
    //called when login with success
    self.viewController= [[JLViewController alloc] init];
    self.window.rootViewController =self.viewController;
    [self.window makeKeyAndVisible];
}
-(void)loginWithError
{
    //called when login with error
}
-(void)loginCancelled
{
    //called when login is cancelled
}

@end
