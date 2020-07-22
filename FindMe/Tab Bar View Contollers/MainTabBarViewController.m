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
@import Contacts;
@import ContactsUI;

@interface MainTabBarViewController () <CNContactPickerDelegate, CNContactViewControllerDelegate>

typedef NS_ENUM(NSInteger, childViewControllers) {
    findMeViewController = 0,
    mapViewController,
    contactsViewController,
    profileViewController,
};

@end

@implementation MainTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndex = mapViewController;
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
        NSArray *selectedContacts = (NSArray *)[Contact contactsWithArray:contacts];
        [DatabaseManager uploadContacts:selectedContacts withCompletion:^(NSError * _Nonnull error) {
            if (error) {
                [self showAlert:error];
            }
            else {
                
            }
        }];
        self.selectedIndex = contactsViewController;
    }
    else {
        
    }
}

- (IBAction)onTapLogOut:(id)sender
{
    [DatabaseManager logOutUser:^(NSError * _Nonnull error) {
        if (!error) {
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

- (void)showAlert:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout Failed"
                                                                   message:error.localizedDescription
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"try again"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
