//
//  GamesViewController.m
//  TestProject
//
//  Created by Fantastic on 01/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "GamesViewController.h"

@interface GamesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (IBAction)easyGameButtonAction:(id)sender {
}
- (IBAction)hardGameButtonAction:(id)sender {
}
- (IBAction)mediumGameButtonAction:(id)sender {
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
