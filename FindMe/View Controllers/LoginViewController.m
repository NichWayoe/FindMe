//
//  LoginViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "LoginViewController.h"
#import "DatabaseManager.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logInButton.enabled = NO;
    [self registerForKeyboardNotifications];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onLogin:(id)sender
{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [DatabaseManager logInUser:username withPassword:password withCompletion:^(NSError * _Nonnull error) {
        if (!error) {
            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
        }
        else {
            [self showAlert:error];
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.passwordField.text.length > 0 && self.usernameField.text.length > 0) {
        self.logInButton.enabled = YES;
    }
    else {
        self.logInButton.enabled = NO;
    }
    return YES;
}

- (IBAction)onSignUp:(id)sender
{
    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.2 animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x, 0 - (kbSize.height/2), self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.2 animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)showAlert:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed"
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
