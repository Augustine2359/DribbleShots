//
//  DSNavigationViewController.h
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSNavigationViewController : UINavigationController

- (void)loadTableWithShotsOfType:(DribbleShotType)dribbleShotType;

@end
