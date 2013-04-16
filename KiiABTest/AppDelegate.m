//
//  AppDelegate.m
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/14/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "AppDelegate.h"

#import <KiiAnalytics/KiiAnalytics.h>

#import "ABStorage.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [KiiAnalytics beginWithID:@"f810f883" andKey:@"093e35605ef2759289083dfe56c3ac2d"];
    
    [ABStorage loadABConfig];
    
    return YES;
}

@end
