//
//  YViewController.m
//  YRouter
//
//  Created by dcwy1130 on 05/23/2018.
//  Copyright (c) 2018 dcwy1130. All rights reserved.
//

#import "YViewController.h"
#import "YRouter/YModuleManager.h"

@interface YViewController () <YModuleProtocol>

@end

@implementation YViewController

Y_EXPORT_MODULE(YModule)

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@ %@", self.class, NSStringFromSelector(_cmd));
    return YES;
}

@end
