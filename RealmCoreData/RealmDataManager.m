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

- (id)addNewPerson:(NSString *)personName avatar:(NSData *)avatarData supervisor:(id)supervisor
{
    RealmPerson *newPerson = [RealmPerson new];
    newPerson.name = personName;
    newPerson.imageData = avatarData;
    newPerson.supervisor = supervisor;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:newPerson];
    [realm commitWriteTransaction];
    
    return newPerson;
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
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:firstJob];
        [realm addOrUpdateObject:secondJob];
        [realm addOrUpdateObject:firstPerson];
        [realm addOrUpdateObject:secondPerson];
        [realm commitWriteTransaction];
        
    });
}

@end
