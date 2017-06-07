//
//  SignupViewController.m
//  TestProject
//
//  Created by Fantastic on 06/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "SignupViewController.h"
#import "UIColor+CreateMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSString+emailValidation.h"


static NSString * const kUserDefaultsKeyApplicationUnlocked = @"Application Unlocked";

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setLayout];
}
- (void) setLayout {
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#5194FF" alpha:1.0f]];
    
    self.btnSignup.layer.cornerRadius = 3.0f;
    [self.btnSignup setTitleColor:[UIColor colorWithHex:@"#5194FF" alpha:1.0f] forState:UIControlStateNormal];
    
    self.txtEmail.layer.cornerRadius = 3.0f;
    self.txtEmail.layer.borderWidth = 1.0f;
    self.txtEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.txtEmail setValue:[UIColor whiteColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [self setEdgeTextField:self.txtEmail];
    
    self.txtPassword.layer.cornerRadius = 3.0f;
    self.txtPassword.layer.borderWidth = 1.0f;
    self.txtPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.txtPassword setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self setEdgeTextField:self.txtPassword];
    
}
- (void) setEdgeTextField:(UITextField *)textField {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textField.frame.size.height)];
    leftView.backgroundColor = textField.backgroundColor;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}
- (IBAction)signupAction:(id)sender {
    if (![self.txtEmail.text isValidEmail]) {
        [self showAlert:@"Alert!" message:@"Email address is invalid" tag:0];
        return;
    }
    if (self.txtPassword.text.length < 6) {
        [self showAlert:@"Alert" message:@"Password length needs 6 characters at least!"  tag:0];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Signing up...";
    NSURLSessionTask *task = [User createUserAccountWithEmail:self.txtEmail.text password:self.txtPassword.text block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            [hud hideAnimated:YES];
            NSInteger status = [[dict valueForKeyPath:@"status"] integerValue];
            if (status == 1) {
                NSString *data = [dict valueForKeyPath:@"data"];
                [self showAlert:@"Alert" message:data tag:1];
            }
            if (status == 0) {
                NSString *data = [dict valueForKeyPath:@"data"];
                [self showAlert:@"Alert!" message:data tag:0];
            }
        }else
            [self showAlert:@"Error!" message:error.description tag:0];
    }];
    [task resume];
}
- (void) showAlert:(NSString *)title message:(NSString *)message tag:(NSInteger)tag {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             if (tag == 1) {
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                             
                         }];
    [alert addAction:ok]; // add action to uialertcontroller
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
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
