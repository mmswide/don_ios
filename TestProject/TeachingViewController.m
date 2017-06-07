//
//  TeachingViewController.m
//  TestProject
//
//  Created by Fantastic on 01/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "TeachingViewController.h"

@interface TeachingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TeachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.titleLabel setAttributedText:[[NSAttributedString alloc] initWithString:@"Stoney Nakoda" attributes:
  @{NSStrokeColorAttributeName : [UIColor blackColor],
    NSForegroundColorAttributeName : [UIColor whiteColor],
    NSStrokeWidthAttributeName : [NSNumber numberWithDouble:-2] }]];
    
}

- (IBAction)cultureNotesButtonAction:(id)sender {
}
- (IBAction)languageButtonAction:(id)sender {
}
- (IBAction)creditsButtonAction:(id)sender {
}
- (IBAction)searchButtonAction:(id)sender {
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
