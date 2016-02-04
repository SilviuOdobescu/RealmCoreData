//
//  RealmDataManager.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "RealmDataManager.h"
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

- (RLMResults<RealmPerson *> *)getArrayOfPersons
{
    RLMResults<RealmPerson *> *persons = [RealmPerson allObjects];
    return persons;
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

@end
