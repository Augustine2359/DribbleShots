//
//  DSTabBarController.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSTabBarController.h"
#import "DSNavigationViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface DSTabBarController () <UITabBarControllerDelegate>

@end

@implementation DSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.delegate = self;
  
  [DSNetworkManager sharedInstance];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
  [self loadShotsOfType:DribbleShotTypeDebuts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
  DribbleShotType dribbleShotType = [self.viewControllers indexOfObject:viewController];
  [self loadShotsOfType:dribbleShotType];
  
  [[DSNetworkManager sharedInstance] getShotsOfType:dribbleShotType
                                             onPage:1 success:^(NSArray *shots) {
                                               [[DSDataManager sharedInstance] getShotsOfType:dribbleShotType];
                                             } failure:nil];
}

- (void)loadShotsOfType:(DribbleShotType)dribbleShotType {
  [[DSNetworkManager sharedInstance] getShotsOfType:dribbleShotType
                                             onPage:1
                                            success:^(NSArray *shots) {
                                              DSNavigationViewController *navigationViewController = (DSNavigationViewController *)self.selectedViewController;
                                              [navigationViewController loadTableWithShotsOfType:dribbleShotType];
                                            } failure:nil];
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
