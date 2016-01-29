//
//  DataManager.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "CoreDataManager.h"
#import "Job.h"
#import "Person.h"

@implementation CoreDataManager

static dispatch_once_t onceToken;
+ (CoreDataManager *)sharedManager
{
    static CoreDataManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)insertInfoInCoreData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        privateContext.parentContext = self.managedObjectContext;
        
        Job *firstJob = (Job *)[NSEntityDescription insertNewObjectForEntityForName:@"Job" inManagedObjectContext:privateContext];
        firstJob.name = @"Developer";
        Job *secondJob = (Job *)[NSEntityDescription insertNewObjectForEntityForName:@"Job" inManagedObjectContext:privateContext];
        secondJob.name = @"Manager";
        
        Person *firstPerson = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:privateContext];
        firstPerson.name = @"John";
        firstPerson.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"firstAvatar"]);
        
        Person *secondPerson = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:privateContext];
        secondPerson.name = @"Jane";
        secondPerson.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"secondAvatar"]);
        
        firstPerson.supervisor = secondPerson;
        firstPerson.job = firstJob;
        secondPerson.job = secondJob;
        
        NSError *error = nil;
        if ([privateContext hasChanges] && ![privateContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    });
}

- (NSArray *)getArrayOfPersons
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *records = [self.managedObjectContext executeFetchRequest:request error:nil];
    return records;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Alfresco.RealmCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RealmCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RealmCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
