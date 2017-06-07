//
//  MainViewController.m
//  TestProject
//
//  Created by Fantastic on 01/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "MainViewController.h"
#import "CategoryViewController.h"
#import "CultureViewController.h"
#import "GamesViewController.h"
#import "TeachingViewController.h"
#import "QuizzesViewController.h"
#import "User.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goCategoryVC:(id)sender {
    CategoryViewController *categoryVC;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        categoryVC = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    } else {
        categoryVC = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController~ipad" bundle:nil];
    }
    
    [self.navigationController pushViewController:categoryVC animated:YES];
}
- (IBAction)goCultureVC:(id)sender {
    CultureViewController *cultureVC;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cultureVC = [[CultureViewController alloc] initWithNibName:@"CultureViewController" bundle:nil];
    } else {
        cultureVC = [[CultureViewController alloc] initWithNibName:@"CultureViewController~ipad" bundle:nil];
    }
    [self.navigationController pushViewController:cultureVC animated:YES];
}
- (IBAction)goGamesVC:(id)sender {
    GamesViewController *gamesVC;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        gamesVC = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
    } else {
        gamesVC = [[GamesViewController alloc] initWithNibName:@"GamesViewController~ipad" bundle:nil];
    }
    
    [self.navigationController pushViewController:gamesVC animated:YES];
}
- (IBAction)goTeachingVC:(id)sender {
    TeachingViewController *teachingVC;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        teachingVC = [[TeachingViewController alloc] initWithNibName:@"TeachingViewController" bundle:nil];
    } else {
        teachingVC = [[TeachingViewController alloc] initWithNibName:@"TeachingViewController~ipad" bundle:nil];
    }
    [self.navigationController pushViewController:teachingVC animated:YES];
}
- (IBAction)goQuizzesVC:(id)sender {
    QuizzesViewController *quizVC;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        quizVC = [[QuizzesViewController alloc] initWithNibName:@"QuizzesViewController" bundle:nil];
    } else {
        quizVC = [[QuizzesViewController alloc] initWithNibName:@"QuizzesViewController~ipad" bundle:nil];
    }
    [self.navigationController pushViewController:quizVC animated:YES];
}
- (IBAction)logoutAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Signing out...";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSURLSessionTask *task = [User signoutWithUserToken:token block:^(BOOL success, NSError *error) {
        [hud hideAnimated:YES];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate logoutAuth];
    }];
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
