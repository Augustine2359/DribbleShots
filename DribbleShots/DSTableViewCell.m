//
//  DSTableViewCell.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSTableViewCell.h"


@interface DSTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *likesLabel;
@property (nonatomic, strong) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *smallImageView;

@end

@implementation DSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateWithShot:(Shot *)shot {
  self.smallImageView.image = nil;
  if (shot == nil) {
    self.titleLabel.text = nil;
    self.likesLabel.text = nil;
    self.playerNameLabel.text = nil;
    return;
  }
  self.titleLabel.text = [shot title];
  self.likesLabel.text = [NSString stringWithFormat:@"%@ likes", [shot likes]];
  self.playerNameLabel.text = [shot playerName];
  [[DSNetworkManager sharedInstance] setImageWithURLString:[shot imageURL] forImageView:self.smallImageView];
}

- (UIImage *)imageInCell {
  return [self.smallImageView image];
}

@end
