//
//  SceneDelegate.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "SceneDelegate.h"
#import "DatabaseManager.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
{
    [DatabaseManager checkForPersistentUser:^(bool isUserloggedIn) {
        if(isUserloggedIn) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
        }
        else {
            
        }
    }];
}

@end
