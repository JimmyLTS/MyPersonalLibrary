//
//  JLConfigurationHelper.h
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/15.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLConfigurationHelper : NSObject

+ (void)setApplicationStartupDefaults;

+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectKey;

+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectKey;

+ (void)setBoolValueForConfigurationKey:(NSString *)_objectKey withValue:(BOOL)_boolValue;

+ (void)setStringValueForConfigurationKey:(NSString *)_objectKey withValue:(NSString *)_strValue;

@end
