//
//  MigrationManager.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "MigrationManager.h"
#import <CoreData/CoreData.h>

//core data based classes
#import "Person.h"
#import "Job.h"

//realm based classes
#import "RealmPerson.h"
#import "RealmJob.h"

@interface MigrationManager()

@property (nonatomic, strong) id<DataLayerManagerProtocol> initialStore;
@property (nonatomic, strong) id<DataLayerManagerProtocol> finalStore;

@end

@implementation MigrationManager

- (instancetype)initWithInitialStore:(id<DataLayerManagerProtocol>)initialStore newStore:(id<DataLayerManagerProtocol>)newStore
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    
    self.initialStore = initialStore;
    self.finalStore = newStore;
    
    return self;
}

- (void)initiateMigrationProcess
{
    NSLog(@"start initiate transition process");
    
    NSArray *coreDataInfo = [self.initialStore getArrayOfPersons];
    NSMutableDictionary *supervisorMappingDictionary = [NSMutableDictionary new];
    
    for(Person *object in coreDataInfo)
    {
        RealmJob *job = nil;
        if(object.job)
        {
            job = [self.finalStore findOrAddJob:object.job.name];
        }
        if(object.supervisor)
        {
            supervisorMappingDictionary[object.name] = object.supervisor.name;
        }
        
        [self.finalStore addNewPerson:object.name avatar:object.imageData job:object.job.name];
    }
    [self.finalStore mapPersonRelations:supervisorMappingDictionary];
    
    
    NSLog(@"end initiate transition process");
}

@end
