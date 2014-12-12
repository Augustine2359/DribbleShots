//
//  DSNavigationViewController.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSNavigationViewController.h"
#import "DSTableViewController.h"

@interface DSNavigationViewController ()

@end

@implementation DSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableWithShotsOfType:(DribbleShotType)dribbleShotType {
  DSTableViewController *tableViewController = self.viewControllers[0];
  [tableViewController loadTableWithShotsOfType:dribbleShotType];
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
