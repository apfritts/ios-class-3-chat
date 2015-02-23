//
//  ViewController.m
//  ExerciseW3
//
//  Created by AP Fritts on 2/21/15.
//  Copyright (c) 2015 Box. All rights reserved.
//

#import "ChatViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *workingSpinner;
- (IBAction)signUpTap:(id)sender;
- (IBAction)signInTap:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signUpTap:(id)sender {
    [self setWorking:YES];
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text block:^(PFUser *user, NSError *error) {
        if (!error && user) {
            [self performSegueWithIdentifier:@"showChatController" sender:self];
        } else {
            [self setWorking:NO];
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)signInTap:(id)sender {
    [self setWorking:YES];
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self performSegueWithIdentifier:@"showChatController" sender:self];
                                        } else {
                                            [self setWorking:NO];
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hmmm" message:[NSString stringWithFormat:@"We couldn't log you in with these credentials:\n%@", error.description] delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles:nil];
                                            [alert show];
                                            [self.usernameField becomeFirstResponder];
                                        }
                                    }];
}

-(void)setWorking:(BOOL)working {
    if (working) {
        [self.workingSpinner startAnimating];
    } else {
        [self.workingSpinner stopAnimating];
    }
    [self.registerButton setEnabled:!working];
    [self.loginButton setEnabled:!working];
}

@end
