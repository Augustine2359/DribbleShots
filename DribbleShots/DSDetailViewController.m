//
//  DSDetailViewController.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSDetailViewController.h"

@interface DSDetailViewController ()

@property (nonatomic, strong) Shot *shot;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *likesLabel;
@property (nonatomic, strong) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation DSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.titleLabel.text = [self.shot title];
  self.imageView.image = self.image;
  self.likesLabel.text = [NSString stringWithFormat:@"%@ likes", [self.shot likes]];
  self.playerNameLabel.text = [self.shot playerName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateWithShot:(Shot *)shot andImage:(UIImage *)image {
  self.shot = shot;
  self.image = image;
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
