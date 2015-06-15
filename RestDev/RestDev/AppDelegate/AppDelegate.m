//
//  AppDelegate.m
//  RestDev
//
//  Created by XueYulun on 15/6/15.
//  Copyright (c) 2015年 __Dylan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //! Enable Log
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    //! Listen Request
    [HTTPServer ListenHTTPRequest];
    [[HTTPServer sharedInstance] AddScheme:@"/Student" file:@"student.json"];
    [[HTTPServer sharedInstance] AddScheme:@"/Car" file:@"car.json"];
    
    //! Add Mapping Object
    [MapEngin MapStudent];
    [MapEngin MapCar];
    
    //! Net Request ActivityIndicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}

@end
