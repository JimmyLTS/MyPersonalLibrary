//
//  JLCrashHandler.h
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLCrashHandler : NSObject
{
    BOOL dismissed;
}

void InstallCrashExceptionHandler();

@end
