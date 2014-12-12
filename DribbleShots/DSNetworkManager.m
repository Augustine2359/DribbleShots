//
//  DSNetworkManager.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@implementation DSNetworkManager

+(instancetype)sharedInstance {
  static dispatch_once_t pred;
  static id __singleton = nil;
	
  dispatch_once(&pred, ^{ __singleton = [[self alloc] init]; });
  return __singleton;
}

- (void)getShotsOfType:(DribbleShotType)dribbleShotType
                onPage:(NSInteger)page
               success:(void (^)(NSArray *))success {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  NSString *urlString;
  switch (dribbleShotType) {
    case DribbleShotTypeDebuts:
      urlString = @"http://api.dribbble.com/shots/debuts";
      break;
    case DribbleShotTypeEveryone:
      urlString = @"http://api.dribbble.com/shots/everyone";
      break;
    case DribbleShotTypePopular:
      urlString = @"http://api.dribbble.com/shots/popular";
      break;
    default:
      break;
  }
  
  NSDictionary *parameters = @{@"page": [NSNumber numberWithInteger:page]};
  
  [manager GET:urlString
    parameters:parameters
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *shots = responseObject[@"shots"];
         [[DSDataManager sharedInstance] addShotsToModel:shots shotType:dribbleShotType];
         
         if (success)
           success(shots);
         
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         DLog(@"%@", operation);
         DLog(@"%@", error);
       }];
}

- (void)setImageWithURLString:(NSString *)urlString forImageView:(UIImageView *)imageView {
  [imageView setImageWithURL:[NSURL URLWithString:urlString]];
}

@end
