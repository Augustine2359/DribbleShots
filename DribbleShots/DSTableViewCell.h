//
//  DSTableViewCell.h
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSTableViewCell : UITableViewCell

- (void)populateWithShot:(Shot *)shot;
- (UIImage *)imageInCell;

@end
