//
//  Job+CoreDataProperties.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 03/02/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Job.h"

NS_ASSUME_NONNULL_BEGIN

@interface Job (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Person *> *person;

@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet<Person *> *)values;
- (void)removePerson:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
