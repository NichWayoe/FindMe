//
//  SignUpViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "SignUpViewController.h"
#import "DatabaseManager.h"
#import "User.h"

@interface SignUpViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong,nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPasswordStatus;
@property (weak, nonatomic) IBOutlet UILabel *emailStatus;
@property (weak, nonatomic) IBOutlet UILabel *passwordStatus;
@property (weak, nonatomic) IBOutlet UIView *photoSourceView;
@property (nonatomic) bool isValidEmailField;
@property (nonatomic) bool isValidPasswordField;
@property (nonatomic) bool isValidFirstNameField;
@property (nonatomic) bool isValidConfirmPasswordField;
@property (nonatomic) bool isValidLastNameField;
@property (nonatomic) bool isValidUsernameNameField;


@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoSourceView.alpha = 0;
    self.photoSourceView.layer.cornerRadius = 10;
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height;
    [self setTextFields];
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    self.registerButton.enabled = NO;
}

- (void)setTextFields
{
    [self hideAlertLabels];
    [self registerForKeyboardNotifications];
    [self createBottomBorder:self.firstNameField];
    [self createBottomBorder:self.lastNameField];
    [self createBottomBorder:self.emailField];
    [self createBottomBorder:self.passwordField];
    [self createBottomBorder:self.userNameField];
    [self createBottomBorder:self.confirmPasswordField];
    self.profilePhoto.layer.cornerRadius = 50;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
    self.photoSourceView.alpha = 0;
}

- (void)hideAlertLabels
{
    self.passwordStatus.hidden = YES;
    self.confirmPasswordStatus.hidden = YES;
    self.emailStatus.hidden = YES;
}

- (IBAction)showPhotoSourceView:(id)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.photoSourceView.alpha = 1;
    }];
}

- (IBAction)onTapCameraButton:(id)sender
{
    [self uploadProfilePhoto:@"camera"];
    self.photoSourceView.alpha = 0;
}

- (IBAction)onTapLibraryButton:(id)sender
{
    [self uploadProfilePhoto:@"Library"];
    self.photoSourceView.alpha = 0;
}

- (void)uploadProfilePhoto:(NSString* )source
{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([source isEqualToString:@"camera"]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)createBottomBorder:(UITextField *)textField
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
}

- (IBAction)onRegister:(id)sender
{
    NSData *profilePhotoData;
    if (self.profilePhoto.image) {
        profilePhotoData =  UIImagePNGRepresentation(self.profilePhoto.image);
    }
    else {
        profilePhotoData = nil;
    }
    NSDictionary *userDetails = @{
        @"username": self.userNameField.text,
        @"firstName": self.firstNameField.text,
        @"lastName": self.lastNameField.text,
        @"email": self.emailField.text,
        @"password": self.passwordField.text,
        @"profileImage": profilePhotoData
    };
    User *user= [[User alloc] initWithDictionary:userDetails];
    [DatabaseManager saveUser:user withCompletion:^(NSError * _Nonnull error) {
        if (error != nil) {
            [self showAlert:(error)];
        }
        else {
            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.profilePhoto.image = [self resizeImage:editedImage withSize:CGSizeMake(414, 414)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size
{
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)onEditingPasswordField:(id)sender
{
    self.passwordStatus.hidden = NO;
    if (self.passwordField.text.length < 7) {
        self.passwordStatus.text = @"too short";
        self.passwordStatus.textColor = [UIColor redColor];
        self.isValidPasswordField = NO;
    }
    else {
        self.passwordStatus.hidden = YES;
        self.isValidPasswordField = YES;
    }
}

- (IBAction)onDoneEditingFirstNameField:(id)sender
{
    if (self.firstNameField.text.length > 1) {
        self.isValidFirstNameField = YES;
    }
    else {
        self.isValidFirstNameField = NO;
    }
}

- (IBAction)onDoneEditingLastName:(id)sender
{
    if (self.lastNameField.text.length > 1) {
        self.isValidLastNameField = YES;
    }
    else {
        self.isValidLastNameField = NO;
    }
}

- (IBAction)onDoneEditingUsernameField:(id)sender
{
    if (self.userNameField.text.length > 4) {
        self.isValidUsernameNameField = YES;
    }
    else {
        self.isValidUsernameNameField = NO;
    }
}

- (IBAction)onDoneEditingEmailField:(id)sender
{
    self.emailStatus.hidden = NO;
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if (![emailTest evaluateWithObject:self.emailField.text]) {
        self.emailStatus.text = @"invalid email";
        self.emailStatus.textColor = [UIColor redColor];
        self.isValidEmailField = NO;
    }
    else {
        self.emailStatus.hidden = YES;
        self.isValidEmailField = YES;
    }
}

- (IBAction)onEditingConfirmPasswordField:(id)sender
{
    self.confirmPasswordStatus.hidden = NO;
    if ([self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
        self.confirmPasswordStatus.text = @"Passwords match";
        self.isValidConfirmPasswordField = YES;
        self.confirmPasswordStatus.textColor = [UIColor greenColor];
    }
    else {
        self.confirmPasswordStatus.text = @"Passwords don't match";
        self.confirmPasswordStatus.textColor = [UIColor redColor];
        self.isValidConfirmPasswordField = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.isValidEmailField && self.isValidLastNameField && self.isValidPasswordField && self.firstNameField) {
        if (self.confirmPasswordField && self.isValidUsernameNameField) {
            self.registerButton.enabled = YES;
        }
        else {
            self.registerButton.enabled = NO;
        }
    }
    else {
        self.registerButton.enabled = NO;
    }
    return YES;
}

- (void)showAlert:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sign Up Failed"
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
