//
//  SignUpViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "SignUpViewController.h"
#import "DatabaseManager.h"

@interface SignUpViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height;
    [self setTextFields];
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}

-(void)setTextFields
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
}

- (void)hideAlertLabels
{
    self.passwordStatus.hidden = YES;
    self.confirmPasswordStatus.hidden = YES;
    self.emailStatus.hidden = YES;
}

- (IBAction)uploadProfilePhoto:(id)sender
{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
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
        profilePhotoData =  UIImagePNGRepresentation(self.profilePhoto.image);}
    else {
        profilePhotoData = nil;
    }
    NSDictionary *userDetails = @{@"username":self.userNameField.text,
                                  @"firstName":self.firstNameField.text,
                                  @"lastName":self.lastNameField.text,
                                  @"email":self.emailField.text,
                                  @"password":self.passwordField.text,
                                  @"profileImage":profilePhotoData};
    [DatabaseManager createUser:userDetails withCompletion:^(NSError * _Nonnull error) {
        if (error != nil) {
            NSLog(@"error %@s", error.localizedDescription);
            [self showAlert:(error)];
        }
        else {
            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
        }}];
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
    }
    else {
        self.passwordStatus.hidden = YES;
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
    }
    else {
        self.emailStatus.hidden = YES;
    }
}

- (IBAction)onEditingConfirmPasswordField:(id)sender
{
    self.confirmPasswordStatus.hidden = NO;
    if ([self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
        self.confirmPasswordStatus.text = @"Passwords match";
        self.confirmPasswordStatus.textColor = [UIColor greenColor];
    }
    else {
        self.confirmPasswordStatus.text = @"Passwords don't match";
        self.confirmPasswordStatus.textColor = [UIColor redColor];
    }
}

-(void)showAlert:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed"
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
