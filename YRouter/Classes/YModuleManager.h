//
//  YModuleManager.h
//  YRouter_Example
//
//  Created by 悠然一指 on 2018/5/23.
//  Copyright © 2018年 yryz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YModuleProtocol <UIApplicationDelegate>

@optional
+ (instancetype)sharedInstance;

@end

@interface YModuleManager : NSObject

@property (readonly, nonatomic) NSArray<id<YModuleProtocol>> *allModules;

+ (instancetype)sharedInstance;

+ (void)registerClass:(Class)aClass forProtocol:(Protocol *)protocol;

+ (Class)classForProtocol:(Protocol *)protocol;

@end
