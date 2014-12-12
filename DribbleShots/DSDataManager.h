//
//  DSDataManager.h
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSDataManager : NSObject

+ (instancetype)sharedInstance;
- (void)addShotsToModel:(NSArray *)shots
               shotType:(DribbleShotType)dribbleShotType;
- (NSArray *)getShotsOfType:(DribbleShotType)dribbleShotType;

@end
