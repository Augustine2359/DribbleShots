//
//  DSNetworkManager.h
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  DribbleShotTypeDebuts = 0,
  DribbleShotTypeEveryone,
  DribbleShotTypePopular
} DribbleShotType;

@interface DSNetworkManager : NSObject

+ (instancetype)sharedInstance;
- (void)getShotsOfType:(DribbleShotType)dribbleShotType
                onPage:(NSInteger)page
               success:(void (^)(NSArray *))success;


@end
