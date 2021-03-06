//
//  DSDataManager.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSDataManager.h"
#import "Shot.h"

@interface DSDataManager()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DSDataManager

+(instancetype)sharedInstance {
  static dispatch_once_t pred;
  static id __singleton = nil;
  
  dispatch_once(&pred, ^{ __singleton = [[self alloc] init]; });
  return __singleton;
}

- (id)init {
  self = [super init];
  if (self) {
    self.context = [[NSManagedObjectContext alloc] init];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DSModel" withExtension:@"momd"];
    self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    self.context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd hh:mm:ss Z";
  }
  
  return self;
}

- (void)addShotsToModel:(NSArray *)shots shotType:(DribbleShotType)dribbleShotType {
  NSError * error;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Shot"];
  for (NSDictionary *shotDictionary in shots) {
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"idNumber == %@", shotDictionary[@"id"]];
    fetchRequest.fetchLimit = 1;
    if ([self.context countForFetchRequest:fetchRequest error:&error] > 0) {
      continue;
    }
    
    NSEntityDescription *shotEntityDescription = [NSEntityDescription entityForName:@"Shot"
                                                         inManagedObjectContext:self.context];
    Shot *shot = [[Shot alloc] initWithEntity:shotEntityDescription
               insertIntoManagedObjectContext:self.context];
    shot.title = shotDictionary[@"title"];
    shot.imageURL = shotDictionary[@"image_url"];
    shot.dribbleShotType = [NSNumber numberWithInteger:dribbleShotType];
    shot.likes = shotDictionary[@"likes_count"];
    shot.playerName = shotDictionary[@"player"][@"name"];
    shot.idNumber = shotDictionary[@"id"];
    DLog(@"%@", shot);
  }
}

- (NSArray *)getShotsOfType:(DribbleShotType)dribbleShotType {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Shot"];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"dribbleShotType == %@", [NSNumber numberWithInteger:dribbleShotType]];
  fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"idNumber" ascending:NO]];
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:self.context
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:nil];
  NSError * error;
  [fetchedResultsController performFetch:&error];
  return [fetchedResultsController fetchedObjects];
}

@end
