//
//  MainTabBarViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/16/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SceneDelegate.h"
#import "DatabaseManager.h"
#import "LoginViewController.h"
#import "Contact.h"
#import "Parse/Parse.h"
@import Contacts;
@import ContactsUI;

@interface MainTabBarViewController ()<CNContactPickerDelegate, CNContactViewControllerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndex = 1;
}

- (IBAction)onTapAddContact:(id)sender
{
    CNContactPickerViewController *contactPicker = [CNContactPickerViewController new];
    contactPicker.delegate = self;
    [self presentViewController:contactPicker animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts
{
    if (contacts.count >= 1) {
        [Contact uploadContacts:contacts
                 withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"error %@", error.localizedDescription);
            }
            else {
                 self.selectedIndex = 2;
            }
        }];
      
    }
}

- (IBAction)onTapLoyout:(id)sender
{
    [DatabaseManager logOutUser:^(bool didlogOut, NSError * _Nonnull error) {
        if(didlogOut){
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            myDelegate.window.rootViewController = loginViewController;
        }
        else {
            [self showAlert:error];
            
        }
    }];
}

-(void)showAlert:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout Failed"
                                                                   message:error.localizedDescription
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"try again"
                                                       style:UIAlertActionStyleDefault
                               
                                                     handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

@end
