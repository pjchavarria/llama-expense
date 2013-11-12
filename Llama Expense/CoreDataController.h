//
//  HabitStore.h
//  HabitPwner
//
//  Created by Paul Chavarria Podoliako on 29/04/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataController *)sharedInstance;
- (void)saveContext;

@end
