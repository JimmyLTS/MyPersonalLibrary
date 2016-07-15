//
//  JLConfigurationHelper.m
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/15.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import "JLConfigurationHelper.h"

@implementation JLConfigurationHelper

+ (void)setApplicationStartupDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setBool:NO forKey:kJLFirstLaunch];
    [defaults setBool:NO forKey:kJLAuthenticated];
    [defaults synchronize];
}

+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectKey
{
    //creat an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];         //let's make sure the object is synchronized
    return [defaults boolForKey:_objectKey];
}

+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectKey
{
    //creat an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];         //let's make sure the object is synchronized
    if ([defaults stringForKey:_objectKey] == nil) {
        return  @"";
    }else {
        return [defaults stringForKey:_objectKey];
    }
}

+ (void)setBoolValueForConfigurationKey:(NSString *)_objectKey withValue:(BOOL)_boolValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];         //let's make sure the object is synchronized
    [defaults setBool:_boolValue forKey:_objectKey];
    [defaults synchronize];
}

+ (void)setStringValueForConfigurationKey:(NSString *)_objectKey withValue:(NSString *)_strValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];         //let's make sure the object is synchronized
    [defaults setValue:_strValue forKey:_objectKey];
    [defaults synchronize];
}

@end
