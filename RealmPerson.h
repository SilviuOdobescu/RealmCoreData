//
//  RealmPerson.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Realm/Realm.h>

@class RealmJob;

@interface RealmPerson : RLMObject

@property NSString *uuid;
@property NSData *imageData;
@property NSString *name;
@property RealmJob *job;
@property RealmPerson *supervisor;
@property RealmPerson *teamMembers;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmPerson>
RLM_ARRAY_TYPE(RealmPerson)
