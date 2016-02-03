//
//  RealmDataManager.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "RealmDataManager.h"
#import "RealmJob.h"
#import "RealmPerson.h"
#import <UIKit/UIKit.h>

@implementation RealmDataManager

static dispatch_once_t onceToken;
+ (RealmDataManager *)sharedManager
{
    static RealmDataManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (RealmJob *)addNewJob:(NSString *)jobName
{
    RealmJob *newJob = [RealmJob new];
    newJob.name = jobName;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:newJob];
    [realm commitWriteTransaction];
    
    return newJob;
}

- (RLMResults<RealmPerson *> *)getArrayOfPersons
{
    RLMResults<RealmPerson *> *persons = [RealmPerson allObjects];
    return persons;
}

- (void)addNewPerson:(NSString *)personName avatar:(NSData *)avatarData job:(NSString *)jobName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        RealmPerson *newPerson = [RealmPerson new];
        newPerson.name = personName;
        newPerson.imageData = avatarData;
        newPerson.job = [RealmJob objectsWhere:@"name == %@", jobName].firstObject;
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        // You only need to do this once (per thread)
        
        // Add to Realm with transaction
        [realm beginWriteTransaction];
        [realm addObject:newPerson];
        [realm commitWriteTransaction];
        
    });
}

- (void)insertInfoInRealm
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        RealmJob *firstJob = [RealmJob new];
        firstJob.name = @"Developer";
        RealmJob *secondJob = [RealmJob new];
        secondJob.name = @"Manager";
        
        RealmPerson *firstPerson = [RealmPerson new];
        firstPerson.name = @"John";
        firstPerson.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"firstAvatar"]);
        
        RealmPerson *secondPerson = [RealmPerson new];
        secondPerson.name = @"Jane";
        secondPerson.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"secondAvatar"]);
        
        firstPerson.supervisor = secondPerson;
        firstPerson.job = firstJob;
        secondPerson.job = secondJob;
        
        //
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:firstJob];
        [realm addOrUpdateObject:secondJob];
        [realm addOrUpdateObject:firstPerson];
        [realm addOrUpdateObject:secondPerson];
        [realm commitWriteTransaction];
        
    });
}

- (id)personForName:(NSString *)personName
{
    RLMResults *personsResults = [RealmPerson objectsWhere:@"name == %@", personName];
    RealmPerson *personToReturn = nil;
    if(personsResults.count > 0)
    {
        personToReturn = personsResults.firstObject;
    }
    
    return personToReturn;
}

- (id)findOrAddJob:(NSString *)jobName
{
    RLMResults *jobResults = [RealmJob objectsWhere:@"name == %@", jobName];
    if(jobResults.count == 0)
    {
        [self addNewJob:jobName];
    }
    
    return jobResults.firstObject;
}

- (void)mapPersonRelations:(NSDictionary *)mappingInfo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        NSArray *keys = [mappingInfo allKeys];
        for(NSString *key in keys)
        {
            RealmPerson *firstPerson = [RealmPerson objectsWhere:@"name == %@", key].firstObject;
            RealmPerson *secondPerson = [RealmPerson objectsWhere:@"name == %@", mappingInfo[key]].firstObject;
            firstPerson.supervisor = secondPerson;
        }
        [realm commitWriteTransaction];
    });
}

@end
