//
//  Job+CoreDataProperties.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 29/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Job.h"

NS_ASSUME_NONNULL_BEGIN

@interface Job (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END
