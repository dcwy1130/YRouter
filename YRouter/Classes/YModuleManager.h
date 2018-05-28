//
//  YModuleManager.h
//  YRouter_Example
//
//  Created by 悠然一指 on 2018/5/23.
//  Copyright © 2018年 yryz. All rights reserved.
//

#import <UIKit/UIKit.h>

#if defined(__cplusplus)
#define Y_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define Y_EXTERN extern __attribute__((visibility("default")))
#endif

#define Y_EXPORT_MODULE(moduleName) \
Y_EXTERN void YRegisterModule(Class); \
+ (NSString *)moduleName { return @#moduleName; } \
+ (void)load { YRegisterModule(self); }

@protocol YModuleProtocol <UIApplicationDelegate>

@optional
+ (NSString *)moduleName;

@end

@interface YModuleManager : NSObject

@property (readonly, nonatomic) NSArray<id<YModuleProtocol>> *allModules;

+ (instancetype)sharedInstance;

+ (void)registerClass:(Class)aClass forProtocol:(Protocol *)protocol;

+ (Class)classForProtocol:(Protocol *)protocol;

+ (void)broadcastModulesApplicationSelector:(void (^)(id<YModuleProtocol> module))completion;

@end
