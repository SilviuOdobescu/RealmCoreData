//
//  RealmDataManager+CoreDataMigration.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 04/02/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "RealmDataManager+CoreDataMigration.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

//Entities
#import "Person.h"
#import "Job.h"

@implementation RealmDataManager (CoreDataMigration)

- (void)initiateMigrationProcess
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //creating a background context
        NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        privateContext.parentContext = [CoreDataManager sharedManager].managedObjectContext;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
        
        __block NSArray *coreDataPersonRecords = nil;
        __block NSError *coreDataFetchError = nil;
        
        //getting the person information from core data
        [privateContext performBlockAndWait:^{
            coreDataPersonRecords = [privateContext executeFetchRequest:request error:&coreDataFetchError];
        }];
        
        NSLog(@"==== core data information received: %@", coreDataPersonRecords);
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        NSMutableDictionary *supervisorMappingDictionary = [NSMutableDictionary new];
        NSMutableArray *objectsToAddToRealm = [NSMutableArray new];
        
        for(Person *person in coreDataPersonRecords)
        {
            RealmJob *job = nil;
            if(person.job)
            {
                RLMResults *jobResults = [RealmJob objectsWhere:@"name == %@", person.job.name];
                if(jobResults.count == 0)
                {
                    job = [RealmJob new];
                    job.name = person.job.name;
                    [objectsToAddToRealm addObject:job];
                }
                else
                {
                    job = jobResults.firstObject;
                }
                
                if(person.supervisor)
                {
                    supervisorMappingDictionary[person.name] = person.supervisor.name;
                }
                
                RealmPerson *newPerson = [RealmPerson new];
                newPerson.name = person.name;
                newPerson.imageData = person.imageData;
                newPerson.job = job;
                
                [objectsToAddToRealm addObject:newPerson];
            }
        }
        
        [realm beginWriteTransaction];
        for(RLMObject *object in objectsToAddToRealm)
        {
            [realm addOrUpdateObject:object];
        }
        [realm commitWriteTransaction];
        
        [realm beginWriteTransaction];
        NSArray *keys = [supervisorMappingDictionary allKeys];
        for(NSString *key in keys)
        {
            RealmPerson *firstPerson = [RealmPerson objectsWhere:@"name == %@", key].firstObject;
            RealmPerson *secondPerson = [RealmPerson objectsWhere:@"name == %@", supervisorMappingDictionary[key]].firstObject;
            firstPerson.supervisor = secondPerson;
        }
        [realm commitWriteTransaction];
        
    });
}

@end
