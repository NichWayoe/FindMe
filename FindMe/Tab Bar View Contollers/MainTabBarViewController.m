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

typedef NS_ENUM(NSInteger, ChildViewControllers) {
    FindMeViewController = 0,
    MapViewController,
    ContactsViewController,
    ProfileViewController,
};

@end

@implementation MainTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedIndex = MapViewController;
}

- (IBAction)onTapAddContact:(id)sender
{
    CNContactPickerViewController *contactPicker = [CNContactPickerViewController new];
    contactPicker.delegate = self;
    NSPredicate *emailPresentPredicate = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
    contactPicker.predicateForEnablingContact = emailPresentPredicate;
    [self presentViewController:contactPicker animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts
{
    if (contacts.count >= 1) {
        NSArray *selectedContacts = (NSArray *)[Contact contactsWithArray:contacts];
        [DatabaseManager saveContacts:selectedContacts withCompletion:^(NSError * _Nonnull error) {
            if (error) {
                [self showAlert:error];
            }
            else {
                if (self.selectedIndex == ContactsViewController) {
                       [self.childViewControllers[ContactsViewController] viewWillAppear:YES];
                   }
                   else {
                       self.selectedIndex = ContactsViewController;
                   }
            }
        }];
    }
}

- (IBAction)onTapLogOut:(id)sender
{
    [DatabaseManager logOutUser:^(NSError * _Nonnull error) {
        if (!error) {
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navigationController = [UINavigationController new];
            [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            navigationController.viewControllers = @[loginViewController];
            myDelegate.window.rootViewController = navigationController;
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
