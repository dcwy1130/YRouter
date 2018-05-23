//
//  YModuleManager.m
//  YRouter_Example
//
//  Created by 悠然一指 on 2018/5/23.
//  Copyright © 2018年 yryz. All rights reserved.
//

#import "YModuleManager.h"

@interface YModuleManager()
/**
 *  保存了所有已注册的 class - protocol @{@"protocolName": @"className"}
 */
@property (nonatomic, strong) NSMutableDictionary *mapping;
@end

@implementation YModuleManager
{
    NSMutableArray *_allRegisterModules;
}

+ (instancetype)sharedInstance
{
    static YModuleManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _mapping = [NSMutableDictionary dictionary];
        _allRegisterModules = [NSMutableArray array];
    }
    return self;
}

+ (void)registerClass:(Class)aClass forProtocol:(Protocol *)protocol {
    [[self sharedInstance] addClass:aClass forProtocol:protocol];
}

+ (Class)classForProtocol:(Protocol *)protocol {
    return [[self sharedInstance] classForProtocol:protocol];
}

// MARK: - instance method
- (void)addClass:(Class)aClass forProtocol:(Protocol *)protocol {
    if ([aClass respondsToSelector:@selector(sharedInstance)]) {
        id<YModuleProtocol> module = [aClass sharedInstance];
        if (module) {
            [_allRegisterModules addObject:module];
        }
    }
    
    NSString *className = NSStringFromClass(aClass);
    NSString *protocolName = NSStringFromProtocol(protocol);
    [_mapping setObject:className forKey:protocolName];
}

- (Class)classForProtocol:(Protocol *)protocol {
    Class aClass = [_mapping objectForKey:NSStringFromProtocol(protocol)];
    return aClass;
}

- (NSArray<id<YModuleProtocol>> *)allModules {
    return [NSArray arrayWithArray:_allRegisterModules];
}

@end
