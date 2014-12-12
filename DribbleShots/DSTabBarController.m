//
//  DSTabBarController.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSTabBarController.h"

@interface DSTabBarController () <UITabBarControllerDelegate>

@end

@implementation DSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.delegate = self;
  
  [DSNetworkManager sharedInstance];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
  DribbleShotType dribbleShotType = [self.viewControllers indexOfObject:viewController];
  DLog(@"%d", dribbleShotType);
  [[DSNetworkManager sharedInstance] getShotsOfType:dribbleShotType
                                             onPage:1 success:^(NSArray *shots) {
                                               DLog(@"%@", shots);
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
