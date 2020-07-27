//
//  AppDelegate.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
             configuration.applicationId = @"myAppId";
             configuration.server = @"https://findmern.herokuapp.com/parse";
         }];
         [Parse initializeWithConfiguration:config];
    return YES;
}


#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options
{
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
