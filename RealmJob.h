//
//  RealmJob.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Realm/Realm.h>

@class RealmPerson;

@interface RealmJob : RLMObject

@property NSString *name;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmJob>
RLM_ARRAY_TYPE(RealmJob)
