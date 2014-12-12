//
//  DSNetworkManager.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSNetworkManager.h"

@implementation DSNetworkManager

+(instancetype)sharedInstance {
  static dispatch_once_t pred;
  static id __singleton = nil;
	
  dispatch_once(&pred, ^{ __singleton = [[self alloc] init]; });
  return __singleton;
}

- (void)getShotsOfType:(DribbleShotType)dribbleShotType
               success:(void (^)(NSArray *))success {
}

@end
