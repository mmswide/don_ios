//
//  ForgotPassViewController.m
//  TestProject
//
//  Created by Fantastic on 07/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "UIColor+CreateMethods.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "User.h"

@interface ForgotPassViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;

@end

@implementation ForgotPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setLayout];
}

- (void) setLayout {
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#5194FF" alpha:1.0f]];
    
    self.btnReset.layer.cornerRadius = 3.0f;
    [self.btnReset setTitleColor:[UIColor colorWithHex:@"#5194FF" alpha:1.0f] forState:UIControlStateNormal];
    
    self.txtEmail.layer.cornerRadius = 3.0f;
    self.txtEmail.layer.borderWidth = 1.0f;
    self.txtEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.txtEmail setValue:[UIColor whiteColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [self setEdgeTextField:self.txtEmail];
    
}
- (void) setEdgeTextField:(UITextField *)textField {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textField.frame.size.height)];
    leftView.backgroundColor = textField.backgroundColor;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}
- (IBAction)forgotPassAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLSessionTask *task = [User forgetPassWithEmail:self.txtEmail.text block:^(BOOL success, NSString *data, NSError *error) {
        if (!error) {
            [hud hideAnimated:YES];
            [self showAlert:@"Request Password Reset" message:data];
        }else
            [self showAlert:@"Error!" message:error.description];
    }];
}
- (void) showAlert:(NSString *)title message:(NSString *)message {
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
                             
                         }];
    [alert addAction:ok]; // add action to uialertcontroller
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
