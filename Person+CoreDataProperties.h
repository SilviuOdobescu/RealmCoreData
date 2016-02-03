//
//  Person+CoreDataProperties.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 03/02/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *imageData;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Job *job;
@property (nullable, nonatomic, retain) Person *supervisor;
@property (nullable, nonatomic, retain) Person *teamMembers;

@end

NS_ASSUME_NONNULL_END
