//
//  PinCodeViewController.m
//  LanguagePalProiPad
//
//  Copyright © 2016 Thornton Media, Inc. All rights reserved.

#import "PinCodeViewController.h"
#import <MessageUI/MessageUI.h>
#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import "User.h"

#pragma mark -
#pragma mark Constants

static NSString * const kUserDefaultsKeyApplicationUnlocked = @"Application Unlocked";


#pragma mark -
#pragma mark PinCodeViewController private

@interface PinCodeViewController()<MFMailComposeViewControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *_accessCodeTextField;
    IBOutlet UITextField *_pinCodeTextField;
}
@end


#pragma mark -
#pragma mark PinCodeViewController implementation

@implementation PinCodeViewController

#pragma mark -
#pragma mark actions

- (IBAction) applyNowButtonAction: (id) sender
{
    if(![MFMailComposeViewController canSendMail]) {
        [[[UIAlertView alloc] initWithTitle:@"Please setup your email account in settings"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
        return;
    }

    MFMailComposeViewController *controller =
    [MFMailComposeViewController new];
    
    controller.mailComposeDelegate = self;
    
    [controller setSubject: MESSAGE_SUBJECT];
    [controller setToRecipients: @[RECIPIENT_EMAIL]];
    
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction) loginButtonAction: (id) sender
{
//    NSURLSessionTask *task = [User createUserAccountWithEmail:_accessCodeTextField.text password:_pinCodeTextField.text block:^(User *user, NSError *error) {
//        if (!error) {
//            [User saveUser:user];
//            [self unlockApplication];
//        }
//    }];
}


#pragma mark -
#pragma mark methods

+ (BOOL) applicationIsLocked
{
    return [[NSUserDefaults standardUserDefaults]
            boolForKey: kUserDefaultsKeyApplicationUnlocked] == NO;
}


- (void) unlockApplication
{
    [[NSUserDefaults standardUserDefaults]
     setBool: YES forKey: kUserDefaultsKeyApplicationUnlocked];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark autorotation

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}


- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void) mailComposeController: (MFMailComposeViewController *) controller
           didFinishWithResult: (MFMailComposeResult) result
                         error: (NSError *) error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([textField isEqual:_accessCodeTextField]) {
        [_pinCodeTextField becomeFirstResponder];
    }
    return YES;
}
@end
