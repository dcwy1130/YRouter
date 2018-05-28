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
    NSMutableArray<id<YModuleProtocol>> *_allRegisterModules;
    NSMutableDictionary<NSString *, id<YModuleProtocol>> *_moduleData;
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
        _moduleData = [NSMutableDictionary dictionary];
        [self start];
    }
    return self;
}

+ (void)registerClass:(Class)aClass forProtocol:(Protocol *)protocol {
    [[self sharedInstance] addClass:aClass forProtocol:protocol];
}

+ (Class)classForProtocol:(Protocol *)protocol {
    return [[self sharedInstance] classForProtocol:protocol];
}

+ (void)broadcastModulesApplicationSelector:(void (^)(id<YModuleProtocol> module))completion {
    for (id<YModuleProtocol> module in [[self sharedInstance] allModules]) {
        if (completion) {
            completion(module);
        }
    }
}

// MARK: - instance method
- (void)addClass:(Class)aClass forProtocol:(Protocol *)protocol {
    NSString *className = NSStringFromClass(aClass);
    NSString *protocolName = NSStringFromProtocol(protocol);
    [_mapping setObject:className forKey:protocolName];
}

- (Class)classForProtocol:(Protocol *)protocol {
    Class aClass = NSClassFromString([_mapping objectForKey:NSStringFromProtocol(protocol)]);
    return aClass;
}

- (NSArray<id<YModuleProtocol>> *)allModules {
    return [NSArray arrayWithArray:_allRegisterModules];
}

// MARK: - START

static NSMutableArray<Class> *YModuleClasses;
NSArray<Class> *YGetModuleClasses(void)
{
    return YModuleClasses;
}

/**
 * Register the given class as a bridge module. All modules must be registered
 * prior to the first bridge initialization.
 */
void YRegisterModule(Class);
void YRegisterModule(Class moduleClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YModuleClasses = [NSMutableArray new];
    });
    
//    NSAssert([moduleClass conformsToProtocol:@protocol(YModuleProtocol)],
//             [NSString stringWithFormat:@"%@ does not conform to the YModuleProtocol protocol", moduleClass]);

    // Register module
    [YModuleClasses addObject:moduleClass];
}

- (void)start {
    [self registerModulesForClasses:YGetModuleClasses()];
}

- (void)registerModulesForClasses:(NSArray<Class> *)moduleClasses {
    for (Class moduleClass in moduleClasses) {
        NSString *moduleName = NSStringFromClass(moduleClass);
        
        // Check for module name collisions
        id<YModuleProtocol> moduleData = _moduleData[moduleName];
        if (!moduleData) {
            moduleData = [moduleClass new];
            _moduleData[moduleName] = moduleData;
            [_allRegisterModules addObject:moduleData];
        }
    }
}

@end
