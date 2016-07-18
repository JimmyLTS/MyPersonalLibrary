//
//  JLCrashHandler.m
//  MyPersonLibrary
//
//  Created by Mac－mini on 16/7/18.
//  Copyright © 2016年 com.JimmyLTS.www. All rights reserved.
//

#import "JLCrashHandler.h"
#import <libkern/OSAtomic.h>
#import <execinfo.h>

NSString * const JLCrashHandlerSignalExceptionName = @"JLCrashHandlerSignalExceptionName";
NSString * const JLCrashHandlerSignalKey = @"JLCrashHandlerSignalKey";
NSString * const JLCrashHandlerAddressesKey = @"JLCrashHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaxinmum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation JLCrashHandler

+ (NSArray *)backtrace {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount; i < UncaughtExceptionHandlerSkipAddressCount + UncaughtExceptionHandlerReportAddressCount; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    return backtrace;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex {
//    if (anIndex == 0) {
        dismissed = YES;
//    }
}

- (void)handlerException:(NSException *)exception {
    UIAlertView *thisAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"An unexcepted event happened causing the application to shutdown." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [thisAlertView show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed) {
        for (NSString *mode in (NSArray *)CFBridgingRelease(allModes)) {
            CFRunLoopRunInMode((CFStringRef)CFBridgingRetain(mode), 0.001, false);
        }
    }
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqualToString:JLCrashHandlerSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:JLCrashHandlerSignalKey] intValue]);
    }else {
        [exception raise];
    }
}

@end

void HandleException(NSException *exception) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaxinmum) {
        return;
    }
    
    NSArray *callstack = [JLCrashHandler backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callstack forKey:JLCrashHandlerAddressesKey];
    
    [[[JLCrashHandler alloc]init] performSelectorOnMainThread:@selector(handlerException:)
                                                   withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo]
                                                waitUntilDone:YES];
}

void SigalHandler(int signal) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    
    if (exceptionCount > UncaughtExceptionMaxinmum) {
        return;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:JLCrashHandlerSignalKey];
    
    NSArray *callStack = [JLCrashHandler backtrace];
    [userInfo setObject:callStack forKey:JLCrashHandlerAddressesKey];
    
    [[[JLCrashHandler alloc] init] performSelectorOnMainThread:@selector(handlerException:)
                                                    withObject:[NSException exceptionWithName:JLCrashHandlerSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raise.", signal] userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:JLCrashHandlerSignalKey]]
                                                 waitUntilDone:YES];
}

void InstallCrashExceptionHandler() {
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}
